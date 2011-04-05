# == Schema Information
# Schema version: 20110331204648
#
# Table name: target_metrics
#
#  id          :integer         not null, primary key
#  name        :string(255)
#  description :text
#  datatype    :string(255)
#  number      :integer
#  created_at  :datetime
#  updated_at  :datetime
#


require 'spec_helper'

describe TargetMetric do

  it "should create a new instance given valid attributes" do
    tm = Factory(:target_metric)
    tm.should be_valid
  end

  it { should validate_presence_of(:datatype) }
  TargetMetric::DATATYPES.each { |typ| it { should allow_value(typ).for(:datatype) } }

end
