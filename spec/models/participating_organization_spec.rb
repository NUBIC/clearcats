# == Schema Information
# Schema version: 20110331204648
#
# Table name: participating_organizations
#
#  id                        :integer         not null, primary key
#  name                      :string(255)
#  city                      :string(255)
#  country_id                :integer
#  us_state_id               :integer
#  reporting_year            :integer
#  created_at                :datetime
#  updated_at                :datetime
#  ctsa_reporting_years_mask :integer
#

require 'spec_helper'

describe ParticipatingOrganization do
  it "should create a new instance given valid attributes" do
    Factory(:participating_organization)
  end
  
  it { should belong_to(:country) }
  it { should belong_to(:us_state) }
  
  it "should output in a csv format" do
    p = Factory(:participating_organization)
    p.to_comma.should == ["name", "Chicago", "st", "country name", "2000"]
  end
end
