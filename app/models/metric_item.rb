class MetricItem < ActiveRecord::Base
  
  AMOUNT = "Amount"
  NUMBER = "Number"
  DATATYPES = [AMOUNT, NUMBER]
  
  validates_presence_of :datatype
  validates_inclusion_of :datatype, :in => DATATYPES
  
  def to_s
    "#{datatype} of #{name}"
  end
  
end
