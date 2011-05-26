# == Schema Information
# Schema version: 20110523153829
#
# Table name: data_definitions
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  definition :text
#  created_at :datetime
#  updated_at :datetime
#

class DataDefinition < ActiveRecord::Base
end
