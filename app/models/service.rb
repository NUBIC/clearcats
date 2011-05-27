# == Schema Information
# Schema version: 20110523153829
#
# Table name: services
#
#  id              :integer         not null, primary key
#  service_line_id :integer
#  person_id       :integer
#  entered_on      :date
#  state           :string(255)
#  created_at      :datetime
#  updated_at      :datetime
#  created_by      :string(255)
#  updated_by      :string(255)
#  completed_on    :date
#  project_id      :integer
#

# A Service is the record of a client (person_id) having 
# used a service line (service_line_id) provided by the CTSA
require "state_machine"
require "comma"
class Service < ActiveRecord::Base
  
  belongs_to :service_line
  belongs_to :project
  belongs_to :person, :counter_cache => true
  
  has_many :activities, :order => "position, updated_at desc"
  
  delegate :organizational_unit, :to => :service_line
  delegate :ctsa_reporting_years, :to => :person
  
  after_save :create_associations
  before_save :set_dates
  
  scope :shared_with_other_organizational_unit, (lambda do |id| 
    joins("inner join services s2 on s2.person_id = services.person_id inner join service_lines sl1 on sl1.id = services.service_line_id inner join service_lines sl2 on sl2.id = s2.service_line_id") \
    .where("sl1.organizational_unit_id = ? AND sl2.organizational_unit_id <> ?", id, id)
  end)
  scope :for_year, lambda { |yr| where("entered_on BETWEEN '01-01-#{yr}' AND '01-01-#{yr + 1}'")}
  scope :organizational_unit_id_equals, lambda { |id| joins(:service_line).where("service_lines.organizational_unit_id = ?", id) }
  scope :service_line_id_equals, lambda { |id| where("service_line_id = ?", id) }
  
  search_methods :organizational_unit_id_equals

  STATES = ["new", "initiated", "completed", "surveyable"]
  
  state_machine :state, :initial => :new do
    state :new
    state :initiated
    state :completed
    state :surveyable
    
    event :initiate do
      transition [:new] => [:initiated]
    end
    
    event :complete do
      transition [:initiated, :new] => [:completed]
    end
    
    event :readied_for_survey do
      transition [:completed] => [:surveyable]
    end
    
  end
    
  def initialize(attributes = nil)
    super(attributes) # NOTE: This *must* be called, otherwise states won't get initialized
  end

  def to_s(version = :full)
    if service_line.blank?
      if person.blank?
        return "Bad Service"
      else
        return "Service for #{person} does not have a service line"
      end
    else
      ou = version == :short ? "#{service_line.organizational_unit.abbreviation.to_s}"  : service_line.organizational_unit.to_s
      return "#{ou} #{service_line}".strip
    end
  end
  
  def set_dates
    self.entered_on = Date.today if self.entered_on.blank?
  end
  
  def close!
    self.complete
    self.update_attribute(:completed_on, Date.today)
  end

  def complete?
    !completed_on.blank?
  end
  
  def create_associations
    add_organizational_unit_to_person
    create_placeholder_activities
  end
  
  def remove_associations
    remove_organizational_unit_from_person
    remove_placeholder_activities
  end
  
  def add_organizational_unit_to_person
    if should_add_organizational_unit_to_person?
      self.person.organizational_units << self.service_line.organizational_unit 
      self.person.save!
    end
  end
  
  def remove_organizational_unit_from_person
    if should_remove_organizational_unit_from_person?
      self.person.organizational_units.delete(self.service_line.organizational_unit)
      self.person.save!
    end
  end
  
  def create_placeholder_activities
    if should_create_placeholder_activities?
      self.service_line.activity_types.each do |at|
        act = Activity.create(:service => self, :service_line => self.service_line, :activity_type => at, :name => "#{at.name}", :created_from_service => true)
        ActivityActor.create(:activity => act, :person => self.person, :role => Role.client)
      end
    end
  end
  
  def remove_placeholder_activities
    activities.each do |a|
      a.destroy if a.event_date.blank?
    end
  end
  
  def destroy
    remove_associations
    super if activities.blank?
  end
  
  def organizational_unit
    service_line.organizational_unit if service_line
  end
  
  # cost and effort
  
  def cost
    Summable.total_cost(activities)
  end
  
  def effort
    Summable.total_effort(activities)
  end
  
  def hours
    Summable.hours(effort)
  end
  
  def minutes
    Summable.minutes(effort)
  end
  
  ###
  #    Support for exporting to CSV
  ###
  
  comma do
    service_line :to_s => "Service Line"
    person :first_name => "First Name"
    person :last_name => "Last Name"
    person :email => "Email"
    entered_on
    completed_on
    state
  end
  
  private
  
    def setup?
      !self.service_line.blank? && !self.person.blank?
    end
  
    def should_create_placeholder_activities?
      activities.blank? && setup?
    end
  
    def should_add_organizational_unit_to_person?
      setup? and !service_line.organizational_unit.blank? and !self.person.organizational_units.include?(self.service_line.organizational_unit)
    end
    
    def should_remove_organizational_unit_from_person?
      setup? and only_person_association_to_organizational_unit_is_through_this_service?
    end
  
    def only_person_association_to_organizational_unit_is_through_this_service?
      svcs = self.person.services.all(:conditions => "services.service_line_id IS NOT NULL") 
      svcs.map(&:organizational_unit).select { |ou| ou.id == self.service_line.organizational_unit.id }.count == 1
    end

end
