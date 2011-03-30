# == Schema Information
# Schema version: 20110329183255
#
# Table name: projects
#
#  id                     :integer         not null, primary key
#  name                   :string(255)
#  organizational_unit_id :integer
#  service_line_id        :integer
#  created_at             :datetime
#  updated_at             :datetime
#

class Project < ActiveRecord::Base
  belongs_to :organizational_unit
  belongs_to :service_line
  has_many :activities

  has_many :notes, :class_name => "Note", :as => :notable, :dependent => :destroy
  accepts_nested_attributes_for :notes, :allow_destroy => true
  
  validates_presence_of :organizational_unit
  validates_presence_of :name

  def to_s
    name
  end
  
end
