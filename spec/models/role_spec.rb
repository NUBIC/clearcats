# == Schema Information
# Schema version: 20110324204242
#
# Table name: roles
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

require 'spec_helper'

describe Role do
  
  it "should create a new instance given valid attributes" do
    r = Factory(:role)
    r.to_s.should == "#{r.name}"
  end
  
  it { should validate_presence_of(:name) }
end
