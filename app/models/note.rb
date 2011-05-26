# == Schema Information
# Schema version: 20110523153829
#
# Table name: notes
#
#  id           :integer         not null, primary key
#  text         :text
#  notable_id   :integer
#  notable_type :string(255)
#  created_at   :datetime
#  updated_at   :datetime
#  created_by   :string(255)
#  updated_by   :string(255)
#

class Note < ActiveRecord::Base
  belongs_to :notable, :polymorphic => true
end
