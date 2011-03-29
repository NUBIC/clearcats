# == Schema Information
# Schema version: 20110324204242
#
# Table name: projects
#
#  id                     :integer         not null, primary key
#  name                   :string(255)
#  organizational_unit_id :integer
#  created_at             :datetime
#  updated_at             :datetime
#

class Project < ActiveRecord::Base
  belongs_to :organizational_unit
  has_many :activities
  has_many :notes, :as => :notable
  
  validates_presence_of :organizational_unit
  validates_presence_of :name

  def to_s
    name
  end
  
end
