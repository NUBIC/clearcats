# == Schema Information
# Schema version: 20110519160226
#
# Table name: participating_organizations
#
#  id                        :integer         not null, primary key
#  name                      :string(255)
#  city                      :string(255)
#  country_id                :integer
#  us_state_id               :integer
#  reporting_year            :integer
#  created_at                :datetime
#  updated_at                :datetime
#  ctsa_reporting_years_mask :integer
#

require 'comma'
class ParticipatingOrganization < ActiveRecord::Base
  include CtsaReportable
  
  scope :all_for_reporting_year, lambda { |yr| {:conditions => "ctsa_reporting_years_mask & #{2**REPORTING_YEARS.index(yr.to_i)} > 0 "} }
  
  search_methods :all_for_reporting_year
  
  has_paper_trail :ignore => [:ctsa_reporting_years_mask]
  
  belongs_to :us_state
  belongs_to :country
  
  comma do
    name
    city
    us_state
    country
    ctsa_reporting_years :to_sentence => "CTSA Reporting Years"
  end
end
