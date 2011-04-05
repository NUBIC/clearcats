# == Schema Information
# Schema version: 20110331204648
#
# Table name: projects
#
#  id                     :integer         not null, primary key
#  name                   :string(255)
#  organizational_unit_id :integer
#  service_line_id        :integer
#  start_at               :datetime
#  end_at                 :datetime
#  created_at             :datetime
#  updated_at             :datetime
#

class Project < ActiveRecord::Base
  belongs_to :organizational_unit
  belongs_to :service_line
  has_many :activities

  has_many :notes, :class_name => "Note", :as => :notable, :dependent => :destroy
  accepts_nested_attributes_for :notes, :allow_destroy => true
  
  has_and_belongs_to_many :key_metrics
  accepts_nested_attributes_for :key_metrics, :allow_destroy => true
  attr_accessor :key_metrics_attributes
  
  validates_presence_of :organizational_unit
  validates_presence_of :name

  def to_s
    name
  end
  
end
