# == Schema Information
# Schema version: 20101202161044
#
# Table name: specialties
#
#  id         :integer         not null, primary key
#  code       :string(255)
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#  created_by :string(255)
#  updated_by :string(255)
#

require 'spec_helper'

describe Specialty do
  it "should create a new instance given valid attributes" do
    Factory(:specialty)
  end
end
