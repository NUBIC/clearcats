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
