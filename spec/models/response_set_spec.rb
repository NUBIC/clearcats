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

require 'spec_helper'

describe ResponseSet do

  # FIXME: when we get Surveyor woeking in Rails 3
  #
  # it { should belong_to(:user) }
  # it { should belong_to(:survey) }
  # 
  # it { should belong_to(:service) }
  # 
  # it "should assign survey to response set" do
  #   rs = ResponseSet.new
  #   rs.survey = Survey.new
  #   rs.survey.should_not be_nil
  # end
  
end
