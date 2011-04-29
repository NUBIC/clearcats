# == Schema Information
# Schema version: 20110429141805
#
# Table name: notes
#
#  id           :integer         not null, primary key
#  text         :text
#  notable_id   :integer
#  notable_type :string(255)
#  created_at   :datetime
#  updated_at   :datetime
#

require 'spec_helper'

describe Note do
  it "should create a new instance given valid attributes" do
    Factory(:note)
  end
  
end
