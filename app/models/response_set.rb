# == Schema Information
# Schema version: 20110511175546
#
# Table name: response_sets
#
#  id           :integer         not null, primary key
#  user_id      :integer(8)
#  survey_id    :integer(8)
#  access_code  :string(255)
#  started_at   :datetime
#  completed_at :datetime
#  created_at   :datetime
#  updated_at   :datetime
#  service_id   :integer
#  created_by   :string(255)
#  updated_by   :string(255)
#

class ResponseSet < ActiveRecord::Base
  unloadable
  # include Surveyor::Models::ResponseSetMethods
  
  belongs_to :service
  
end
