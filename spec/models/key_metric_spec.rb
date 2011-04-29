# == Schema Information
# Schema version: 20110429141805
#
# Table name: key_metrics
#
#  id                     :integer         not null, primary key
#  name                   :string(255)
#  organizational_unit_id :integer
#  target_metric_id       :integer
#  datatype               :string(255)
#  note                   :text
#  created_at             :datetime
#  updated_at             :datetime
#


require 'spec_helper'

describe KeyMetric do

  it "should create a new instance given valid attributes" do
    km = Factory(:key_metric)
    km.should be_valid
    km.to_s.should == "#{km.name}"
  end

  it { should validate_presence_of(:datatype) }
  KeyMetric::DATATYPES.each { |typ| it { should allow_value(typ).for(:datatype) } }

  it { should belong_to(:organizational_unit) }

end
