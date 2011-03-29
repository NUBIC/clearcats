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

require 'spec_helper'

describe Project do
  
  it "should create a new instance given valid attributes" do
    proj = Factory(:project)
    proj.to_s.should == "#{proj.name}"
  end
  
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:organizational_unit) }
  it { should belong_to(:organizational_unit) }
  it { should have_many(:activities) }
  
  # it { should have_many(:notes) }
end
