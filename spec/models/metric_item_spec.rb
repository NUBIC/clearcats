require 'spec_helper'

describe MetricItem do
  
  it "should create a new instance given valid attributes" do
    item = Factory(:metric_item, :datatype => MetricItem::NUMBER, :name => "Investigators")
    item.to_s.should == "#{MetricItem::NUMBER} of Investigators"
  end
  
  it { should validate_presence_of(:datatype) }
  MetricItem::DATATYPES.each { |typ| it { should allow_value(typ).for(:datatype) }  }
  
end