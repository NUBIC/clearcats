# == Schema Information
# Schema version: 20110519160226
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
