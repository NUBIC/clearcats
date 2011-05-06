# == Schema Information
# Schema version: 20110429141805
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
#

# A Service is the record of a client (person_id) having 
# used a service line (service_line_id) provided by the CTSA
require "state_machine"
class Service < ActiveRecord::Base
  
  belongs_to :service_line
  belongs_to :person
  
  delegate :organizational_unit, :to => :service_line
  delegate :ctsa_reporting_years, :to => :person
  
  before_save :create_associations
  before_destroy :remove_associations
  
  scope :organizational_unit_id_equals, lambda { |id| joins(:service_line).where("service_lines.organizational_unit_id = ?", id) }
  
  search_methods :organizational_unit_id_equals

  state_machine :state, :initial => new do
    state :new
    state :initiated
    state :completed
    state :surveyable
    
    event :initiate do
      transition [:new] => [:initiated]
    end
    
    event :complete do
      transition [:initiated] => [:completed]
    end
    
    event :readied_for_survey do
      transition [:completed] => [:surveyable]
    end
    
  end
    
  def initialize(attributes = nil)
    super(attributes) # NOTE: This *must* be called, otherwise states won't get initialized
  end

  def to_s
    if service_line.blank?
      if person.blank?
        return "Bad Service"
      else
        return "Service for #{person} does not have a service line"
      end
    else
      return "#{service_line.organizational_unit.to_s} #{service_line}".strip
    end
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
        act = Activity.new(:service_line => self.service_line, :activity_type => at, :name => "#{at.name}")
        act.activity_actors = [ActivityActor.new(:activity => act, :person => self.person, :role => Role.client)]
        act.save!
      end
    end
  end
  
  def remove_placeholder_activities
    activities.each do |a|
      a.destroy if a.event_date.blank?
    end
  end
  
  def activities
    search = {}
    search[:service_line_id_eq] = service_line_id
    search[:activity_actors_person_id_eq] = person_id
    Activity.search(search).all
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
