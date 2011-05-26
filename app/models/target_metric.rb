# == Schema Information
# Schema version: 20110523153829
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

class TargetMetric < ActiveRecord::Base
  
  NUMBER = "Number"
  PERCENTAGE = "Percentage"
  DATATYPES = [NUMBER, PERCENTAGE]
  
  validates_presence_of :datatype
  validates_inclusion_of :datatype, :in => DATATYPES
  
end
