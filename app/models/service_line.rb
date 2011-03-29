# == Schema Information
# Schema version: 20110324204242
#
# Table name: service_lines
#
#  id                     :integer         not null, primary key
#  name                   :string(255)
#  organizational_unit_id :integer
#  created_at             :datetime
#  updated_at             :datetime
#  created_by             :string(255)
#  updated_by             :string(255)
#

class ServiceLine < ActiveRecord::Base
  
  belongs_to :organizational_unit
  has_many :activity_types
  has_many :services
  
  validates_presence_of :name
  
  accepts_nested_attributes_for :activity_types, :allow_destroy => true
  
  named_scope :for_organizational_units, lambda { |ids| {:conditions => ["organizational_unit_id in (?)", ids]} } 
  
  def to_s
    name
  end
end
