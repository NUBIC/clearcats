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
