# == Schema Information
# Schema version: 20110429141805
#
# Table name: roles
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Role < ActiveRecord::Base
  
  validates_presence_of :name
  
  def to_s
    name
  end

end
