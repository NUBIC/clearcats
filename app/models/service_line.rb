# == Schema Information
# Schema version: 20110511175546
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

# A Service Line is something provided by the CTSA.
# Sometimes this is just a continuing service provided or
# is a template for a repeating project. 
class ServiceLine < ActiveRecord::Base
  
  belongs_to :organizational_unit
  has_many :activity_types, :order => "position"
  has_many :services
  
  validates_presence_of :name
  
  accepts_nested_attributes_for :activity_types, :allow_destroy => true
  
  scope :for_organizational_units, lambda { |ids| {:conditions => ["organizational_unit_id in (?)", ids]} } 
  
  search_methods :for_organizational_units
  
  def to_s
    name
  end
end
