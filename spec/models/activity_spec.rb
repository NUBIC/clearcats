# == Schema Information
# Schema version: 20110324204242
#
# Table name: activities
#
#  id               :integer         not null, primary key
#  name             :string(255)
#  project_id       :integer
#  activity_type_id :integer
#  due_at           :datetime
#  deliverable      :text
#  created_at       :datetime
#  updated_at       :datetime
#

require 'spec_helper'

describe Activity do
  
  it "should create a new instance given valid attributes" do
    act = Factory(:activity)
    act.to_s.should == "#{act.name}"
  end
  
  it { should validate_presence_of(:name) }
  
  it { should belong_to(:project) }
  
  it { should validate_presence_of(:activity_type) }
  it { should belong_to(:activity_type) }
  
  it { should have_many(:attachments) }
  it { should have_many(:activity_actors) }
  
  # it { should have_many(:time_entries) }
  
  describe "associating an activity type by name" do
    
    it "should find and associate an activity type by name" do
      act = Factory.build(:activity, :activity_type => nil)
      act.activity_type.should be_nil
      
      at = Factory(:activity_type, :name => "asdf")
      act.activity_type_name = at.name
      
      act.activity_type.should_not be_nil
      act.activity_type.should == at
    end
    
    it "should find and associate an activity type by name" do
      act = Factory.build(:activity, :activity_type => nil)
      act.activity_type.should be_nil
      
      ActivityType.find_by_name("qwer").should be_nil
      act.activity_type_name = "qwer"
      
      act.activity_type.should_not be_nil
      act.activity_type.name.should.eql?("qwer")
      ActivityType.find_by_name("qwer").should_not be_nil
    end
    
  end
end
