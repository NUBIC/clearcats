# == Schema Information
# Schema version: 20110429141805
#
# Table name: service_requests
#
#  id                     :integer         not null, primary key
#  service_line_id        :integer
#  organizational_unit_id :integer
#  first_name             :string(255)
#  last_name              :string(255)
#  email                  :string(255)
#  project                :string(255)
#  abstract               :text
#  created_at             :datetime
#  updated_at             :datetime
#

class ServiceRequest < ActiveRecord::Base
  validates_presence_of :email
  validates_presence_of :project
  validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i
  belongs_to :service_line
  belongs_to :organizational_unit
  
  def to_s
    project
  end
end
