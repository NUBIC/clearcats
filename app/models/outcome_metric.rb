# == Schema Information
# Schema version: 20110523153829
#
# Table name: outcome_metrics
#
#  id          :integer         not null, primary key
#  activity_id :integer
#  amount      :integer
#  name        :string(255)
#  note        :text
#  created_at  :datetime
#  updated_at  :datetime
#

class OutcomeMetric < ActiveRecord::Base
end
