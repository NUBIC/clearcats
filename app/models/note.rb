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

class Note < ActiveRecord::Base
  belongs_to :notable, :polymorphic => true
end
