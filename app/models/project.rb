# == Schema Information
# Schema version: 20110523153829
#
# Table name: projects
#
#  id                     :integer         not null, primary key
#  name                   :string(255)
#  organizational_unit_id :integer
#  service_line_id        :integer
#  start_at               :datetime
#  end_at                 :datetime
#  billable               :boolean
#  created_at             :datetime
#  updated_at             :datetime
#  completed              :boolean
#

# A project is an instance of a service line for the organizational unit.
# The activities of a project should correspond with the activity types of a service line.
class Project < ActiveRecord::Base
  belongs_to :organizational_unit
  belongs_to :service_line
  has_many :services
  has_many :activities, :through => :services

  has_many :notes, :class_name => "Note", :as => :notable, :dependent => :destroy
  accepts_nested_attributes_for :notes, :allow_destroy => true
  
  has_and_belongs_to_many :key_metrics
  accepts_nested_attributes_for :key_metrics, :allow_destroy => true
  attr_accessor :key_metrics_attributes
  
  validates_presence_of :organizational_unit
  validates_presence_of :service_line
  validates_presence_of :name
  
  after_save :close_activities
  
  scope :active, where("completed = 'false' OR completed IS NULL")
  scope :for_service_line, lambda {|svc_line| where(:service_line_id => svc_line.id) }
  scope :for_organizational_unit, lambda {|org_unit| where(:organizational_unit_id => org_unit.id) }

  def to_s
    name
  end
  
  def complete?
    completed?
  end
  
  def people
    peeps = []
    activities.each do |act|
      act.activity_actors.each do |actor|
        peeps << actor.person unless peeps.include? actor.person
      end
    end
    peeps
  end
  
  def cost
    Summable.total_cost(services)
  end
  
  def effort
    Summable.total_effort(services)
  end
  
  def hours
    Summable.hours(effort)
  end
  
  def minutes
    Summable.minutes(effort)
  end
    
  private
  
    def close_activities
      if complete?
        activities.active.each { |a| a.close! }
      end
    end
  
end
