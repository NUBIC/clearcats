# == Schema Information
# Schema version: 20110510212418
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
  
  def self.client
    Role.find_or_create_by_name("Client")
  end

end
