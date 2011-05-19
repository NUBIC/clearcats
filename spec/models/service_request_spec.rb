# == Schema Information
# Schema version: 20110519160226
#
# Table name: service_requests
#
#  id                     :integer         not null, primary key
#  service_line_id        :integer
#  organizational_unit_id :integer
#  first_name             :string(255)
#  last_name              :string(255)
#  email                  :string(255)
#  project                :string(255)
#  abstract               :text
#  created_at             :datetime
#  updated_at             :datetime
#

require 'spec_helper'

describe ServiceRequest do
  
  it "should create a new instance given valid attributes" do
    req = Factory(:service_request)
    req.to_s.should == "#{req.project}"
  end
  
  it { should validate_presence_of(:email) }
  it { should validate_presence_of(:project) }
  it { should belong_to(:organizational_unit) }
  it { should belong_to(:service_line) }
end
