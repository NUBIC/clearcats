# == Schema Information
# Schema version: 20101202161044
#
# Table name: activity_codes
#
#  id         :integer         not null, primary key
#  code       :string(255)
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#  created_by :string(255)
#  updated_by :string(255)
#

# An ActivityCode is the CTSA name for a Federal Non-PHS Awards
# (e.g. R01 Research Project)
class ActivityCode < ActiveRecord::Base
  validates_presence_of :code
  validates_presence_of :name
  
  has_many :awards
  
  def to_s
    return "#{code} #{name}".strip
  end
  
end
