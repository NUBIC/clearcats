# == Schema Information
# Schema version: 20110331204648
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

class KeyMetric < ActiveRecord::Base
  AMOUNT = "Amount"
  NUMBER = "Number"
  DATATYPES = [AMOUNT, NUMBER]
  
  belongs_to :organizational_unit
  
  validates_presence_of :datatype
  validates_inclusion_of :datatype, :in => DATATYPES
  
  named_scope :for_organizational_units, lambda { |ids| {:conditions => ["organizational_unit_id in (?)", ids]} } 
  
  def to_s
    name
  end
  
end
