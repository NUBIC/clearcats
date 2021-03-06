# http://github.com/thoughtbot/factory_girl/tree/master
require 'rubygems'
require 'factory_girl'

Factory.define :specialty do |s|
  s.code "specialty code"
  s.name "specialty name"
end

Factory.define :activity_code do |a|
  a.code "activity code"
  a.name "activity_code name"
end

Factory.define :non_phs_organization, :class => "NonPhsOrganization" do |org|
  org.code "npo code"
  org.name "non_phs_organization name"
end

Factory.define :phs_organization, :class => "PhsOrganization" do |org|
  org.code "po code"
  org.name "phs_organization name"
end

Factory.define :country do |c|
  c.name "country name"
end

Factory.define :us_state do |s|
  s.name "state"
  s.abbreviation "st"
end

Factory.define :degree_type_one, :class => "DegreeTypeOne" do |dt|
  dt.name "dt1 name"
  dt.abbreviation "dt1"
end

Factory.define :degree_type_two, :class => "DegreeTypeTwo" do |dt|
  dt.name "dt2 name"
  dt.abbreviation "dt2"
end

Factory.define :ethnic_type do |et|
  et.name "ethnic_type name"
end

Factory.define :race_type do |rt|
  rt.name "race_type name"
end

Factory.define :organizational_unit do |ou|
  ou.name                         "organizational_unit name"
  ou.abbreviation                 "ou"
  ou.cc_pers_affiliate_identifier "cc_pers"
end

Factory.define :service_line do |sl|
  sl.name "service line name"
  sl.organizational_unit { |a| a.association(:organizational_unit) }
end

Factory.define :department do |dept|
  dept.name "department name"
end

Factory.define :institution_position do |p|
  p.name "position name"
end

Factory.define :activity_type do |t|
  t.name         "activity type name"
  t.service_line { |a| a.association(:service_line) }
  
  t.due_in_days_after         14
  t.client_reminder           4
  t.client_followup_reminder  1
  t.staff_reminder            4
  t.staff_followup_reminder   1
  t.position                  1
  t.required                  false
  t.dependent_on_previous     false
end


Factory.sequence :netid do |n|
  "netid_#{n}"
end

Factory.define :person do |p|
  p.first_name             "first_name"
  p.middle_name            "X"
  p.last_name              "last_name"
  p.phone                  "phone"
  p.sequence(:email)       { |n| "email#{n}@dev.null" }
  p.last_four_of_ssn       "four"
  p.department_affiliation "dept"
  p.school_affiliation     "school"
  p.era_commons_username   "era_commons"
  p.netid                  { Factory.next(:netid) }
  p.training_type          nil
  p.trainee_status         nil
  p.system_administrator   false

  p.appointment_date       nil
  p.end_date               nil
  p.mentor_era_commons_username nil

  p.country             { |a| a.association(:country) }
  p.degree_type_one     { |a| a.association(:degree_type_one) }
  p.degree_type_two     { |a| a.association(:degree_type_two) }
  p.specialty           { |a| a.association(:specialty) }
end

Factory.define :client do |p|
  p.first_name             "first_name"
  p.middle_name            "middle_name"
  p.last_name              "last_name"
  p.phone                  "phone"
  p.sequence(:email)       { |n| "email#{n}@dev.null" }
  p.last_four_of_ssn       "four"
  p.department_affiliation "dept"
  p.school_affiliation     "school"
  p.era_commons_username   "era_commons"
  p.employeeid             "emplid"
  p.netid                  { Factory.next(:netid) }
  p.training_type          nil
  p.trainee_status         nil
  p.ctsa_reporting_years_mask 1
  
  p.country             { |a| a.association(:country) }
  p.degree_type_one     { |a| a.association(:degree_type_one) }
  p.degree_type_two     { |a| a.association(:degree_type_two) }
  p.specialty           { |a| a.association(:specialty) }
end


Factory.define :service do |svc|
  svc.service_line { |a| a.association(:service_line) }
  svc.person       { |a| a.association(:person) }
end

Factory.define :award do |a|
  a.person            { |a| a.association(:person) }
  a.organization      { |a| a.association(:phs_organization) }
  a.activity_code     { |a| a.association(:activity_code) }
  a.grant_number      "123456"
  a.grant_title       "grant title"
  a.grant_amount      11.00
  a.budget_identifier "NORTHWESTU00000039703000"
  a.ctsa_reporting_years_mask 1
end

Factory.define :phs_award, :class => "Award" do |a|
  a.person            { |a| a.association(:person) }
  a.organization      { |a| a.association(:phs_organization) }
  a.activity_code     { |a| a.association(:activity_code) }
  a.grant_number      "654312"
  a.grant_title       "grant title"
  a.grant_amount      11.00
  a.budget_identifier "NORTHWESTU00000039703000"
  a.ctsa_reporting_years_mask 1
end

Factory.define :non_phs_award, :class => "Award" do |a|
  a.person            { |a| a.association(:person) }
  a.organization      { |a| a.association(:non_phs_organization) }
  a.grant_number      "123456"
  a.grant_title       "grant title"
  a.grant_amount      11.00
  a.budget_identifier "NORTHWESTU00000039703001"
  a.ctsa_reporting_years_mask 1
end

Factory.define :award_detail do |a|
  a.award { |a| a.association(:award) }
  a.budget_number "NORTHWESTU0000003970300060001"
end

Factory.define :sponsor do |sponsor|
  sponsor.name "sponsor name"
end

Factory.define :publication do |pub|
  pub.pmcid             "pmcid"
  pub.pmid              "pmid"
  pub.nihms_number      "nihms_number"
  pub.publication_date  Date.today
  pub.person            { |a| a.association(:person) }
  pub.abstract          "boogadeehoo"
  pub.title             "title"
  pub.cited             true
  pub.missing_pmcid_reason ""
  pub.ctsa_reporting_years_mask 1
end

Factory.define :approval do |a|
  a.tracking_number         "tracking_number"
  a.approval_type           "Other"
  a.project_title           "project_title"
  a.approval_date           Time.now
  a.nucats_assisted         false
  a.principal_investigator  "principal_investigator"
  a.person                  { |a| a.association(:person) }
end

Factory.define :ctsa_report do |r|
  r.created_by      { |a| a.association(:user) }
  r.reporting_year  Time.now.year
  r.grant_number    "123456"
  r.finalized       false
  r.has_errors      false
end

Factory.define :participating_organization do |po|
  po.name "name"
  po.city "Chicago"
  po.country  { |c| c.association(:country) }
  po.us_state { |s| s.association(:us_state) }
  po.ctsa_reporting_years_mask 1
end

Factory.define :user do |u|
  u.first_name     "first_name"
  u.middle_name    "middle_name"
  u.last_name      "last_name"
  u.title          "title"
  u.business_phone "business_phone"
  u.fax            "fax"
  u.email          "email"
  u.username       "username"
  u.employeeid     "employeeid"
  u.personnelid    "personnelid"
  u.address        "address"
  u.city           "city"
  u.state          "state"
  u.country             { |a| a.association(:country) }
  u.organizational_unit { |a| a.association(:organizational_unit) }
end

Factory.define :contact do |c|
  c.sequence(:email) { |n| "contactemail#{n}@dev.null" }
  c.first_name       "first_name"
  c.last_name        "last_name"
  c.company_name     "company_name"
end

Factory.define :contact_list do |c|
  c.name "contact_list"
  c.organizational_unit { |a| a.association(:organizational_unit) }
end

####

Factory.define :project do |p|
  p.name "project name"
  p.completed false
  p.service_line { |a| a.association(:service_line) }
  p.organizational_unit { |a| a.association(:organizational_unit) }
end

Factory.define :activity do |a|
  a.name "activity name"
  a.event_date Date.today
  a.project       { |a| a.association(:project) }
  a.activity_type { |a| a.association(:activity_type) }
  a.service_line  { |a| a.association(:service_line) }
  a.service       { |a| a.association(:service) }
  a.due_date      2.days.from_now
end

Factory.define :role do |r|
  r.name "project name"
end

Factory.define :activity_actor do |a|
  a.activity { |a| a.association(:activity) }
  a.role { |a| a.association(:role) }
  a.person { |a| a.association(:person) }
end

Factory.define :time_entry do |t|
  t.activity { |a| a.association(:activity) }
  t.start_at 1.hour.ago
  t.end_at Time.now
end

Factory.define :note do |note|
  note.text "This is the note"
end

Factory.define :key_metric do |km|
  km.name "Grants"
  km.datatype "Amount"
  km.organizational_unit { |a| a.association(:organizational_unit) }
end

Factory.define :target_metric do |tm|
  tm.name "Grants"
  tm.number 20
  tm.datatype "Percentage"
end

Factory.define :service_request do |req|
  req.first_name          "First Name"
  req.last_name           "Last Name"
  req.email               "email@dev.null"
  req.service_line        { |a| a.association(:service_line) }
  req.organizational_unit { |a| a.association(:organizational_unit) }
  req.project             "Project"
  req.abstract            "Abstract"
end