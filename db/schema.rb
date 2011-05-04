# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20110429141805) do

  create_table "activities", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.integer  "project_id"
    t.integer  "service_line_id"
    t.integer  "activity_type_id"
    t.datetime "event_date"
    t.text     "deliverable"
    t.boolean  "billable"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.date     "due_date"
    t.date     "client_reminder_date"
    t.date     "client_followup_reminder_date"
    t.date     "staff_reminder_date"
    t.date     "staff_followup_reminder_date"
  end

  create_table "activities_people", :force => true do |t|
    t.integer  "activity_id"
    t.integer  "role_id"
    t.integer  "person_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  # unrecognized index "activity_role_person_uniq_idx" with type ActiveRecord::ConnectionAdapters::IndexDefinition

  create_table "activity_codes", :force => true do |t|
    t.string   "code"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "created_by"
    t.string   "updated_by"
  end

  # unrecognized index "index_activity_codes_on_code" with type ActiveRecord::ConnectionAdapters::IndexDefinition
  # unrecognized index "index_activity_codes_on_name" with type ActiveRecord::ConnectionAdapters::IndexDefinition

  create_table "activity_types", :force => true do |t|
    t.string   "name"
    t.integer  "service_line_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "created_by"
    t.string   "updated_by"
    t.integer  "due_in_days_after"
    t.integer  "client_reminder"
    t.integer  "client_followup_reminder"
    t.integer  "staff_reminder"
    t.integer  "staff_followup_reminder"
    t.integer  "position"
    t.boolean  "dependent_on_previous"
  end

  # unrecognized index "index_activity_types_on_name" with type ActiveRecord::ConnectionAdapters::IndexDefinition
  # unrecognized index "index_activity_types_on_service_line_id" with type ActiveRecord::ConnectionAdapters::IndexDefinition

  create_table "answers", :force => true do |t|
    t.integer  "question_id"
    t.text     "text"
    t.text     "short_text"
    t.text     "help_text"
    t.integer  "weight"
    t.string   "response_class"
    t.string   "reference_identifier"
    t.string   "data_export_identifier"
    t.string   "common_namespace"
    t.string   "common_identifier"
    t.integer  "display_order"
    t.boolean  "is_exclusive"
    t.boolean  "hide_label"
    t.integer  "display_length"
    t.string   "custom_class"
    t.string   "custom_renderer"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "approvals", :force => true do |t|
    t.string   "tracking_number"
    t.string   "institution"
    t.string   "approval_type"
    t.string   "project_title"
    t.string   "approval_date"
    t.boolean  "nucats_assisted"
    t.string   "principal_investigator"
    t.integer  "person_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "created_by"
    t.string   "updated_by"
    t.integer  "ctsa_reporting_years_mask"
  end

  # unrecognized index "index_approvals_on_person_id" with type ActiveRecord::ConnectionAdapters::IndexDefinition

  create_table "attachments", :force => true do |t|
    t.string   "name"
    t.integer  "reporting_year"
    t.integer  "attachable_id"
    t.string   "attachable_type"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "data_file_name"
    t.string   "data_content_type"
    t.integer  "data_file_size"
    t.datetime "data_updated_at"
    t.string   "created_by"
    t.string   "updated_by"
  end

  create_table "award_details", :force => true do |t|
    t.integer  "award_id"
    t.string   "budget_period"
    t.date     "budget_period_start_date"
    t.date     "budget_period_end_date"
    t.float    "budget_period_direct_cost"
    t.float    "budget_period_direct_and_indirect_cost"
    t.string   "budget_number"
    t.float    "direct_amount"
    t.float    "indirect_amount"
    t.float    "total_amount"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "created_by"
    t.string   "updated_by"
  end

  # unrecognized index "index_award_details_on_budget_number" with type ActiveRecord::ConnectionAdapters::IndexDefinition

  create_table "awards", :force => true do |t|
    t.string   "grant_number"
    t.string   "grant_title",                  :limit => 2500
    t.float    "grant_amount"
    t.integer  "person_id"
    t.integer  "investigator_id"
    t.string   "role"
    t.string   "parent_institution_number"
    t.string   "institution_number"
    t.string   "subproject_number"
    t.string   "ctsa_award_type_award_number"
    t.date     "project_period_start_date"
    t.date     "project_period_end_date"
    t.float    "project_period_total_cost"
    t.float    "total_project_cost"
    t.integer  "organization_id"
    t.string   "organization_type"
    t.integer  "activity_code_id"
    t.string   "proposal_status"
    t.string   "award_status"
    t.string   "sponsor_award_number"
    t.boolean  "nucats_assisted"
    t.string   "budget_identifier"
    t.boolean  "edited_by_user"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "sponsor_id"
    t.integer  "originating_sponsor_id"
    t.integer  "ctsa_reporting_years_mask"
    t.string   "created_by"
    t.string   "updated_by"
  end

  # unrecognized index "index_awards_on_activity_code_id" with type ActiveRecord::ConnectionAdapters::IndexDefinition
  # unrecognized index "index_awards_on_budget_identifier" with type ActiveRecord::ConnectionAdapters::IndexDefinition
  # unrecognized index "index_awards_on_investigator_id" with type ActiveRecord::ConnectionAdapters::IndexDefinition
  # unrecognized index "index_awards_on_organization_type_and_organization_id" with type ActiveRecord::ConnectionAdapters::IndexDefinition
  # unrecognized index "index_awards_on_originating_sponsor_id" with type ActiveRecord::ConnectionAdapters::IndexDefinition
  # unrecognized index "index_awards_on_person_id" with type ActiveRecord::ConnectionAdapters::IndexDefinition
  # unrecognized index "index_awards_on_sponsor_id" with type ActiveRecord::ConnectionAdapters::IndexDefinition

  create_table "contact_lists", :force => true do |t|
    t.string   "name"
    t.integer  "organizational_unit_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "created_by"
    t.string   "updated_by"
  end

  create_table "contact_lists_contacts", :id => false, :force => true do |t|
    t.integer "contact_id"
    t.integer "contact_list_id"
  end

  # unrecognized index "contact_lists_contacts_idx" with type ActiveRecord::ConnectionAdapters::IndexDefinition

  create_table "contacts", :force => true do |t|
    t.string   "email"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "company_name"
    t.integer  "person_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "created_by"
    t.string   "updated_by"
  end

  # unrecognized index "index_contacts_on_email" with type ActiveRecord::ConnectionAdapters::IndexDefinition

  create_table "contacts_organizational_units", :id => false, :force => true do |t|
    t.integer "organizational_unit_id"
    t.integer "contact_id"
  end

  # unrecognized index "contacts_organizational_units_idx" with type ActiveRecord::ConnectionAdapters::IndexDefinition

  create_table "countries", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "created_by"
    t.string   "updated_by"
  end

  # unrecognized index "index_countries_on_name" with type ActiveRecord::ConnectionAdapters::IndexDefinition

  create_table "ctsa_reports", :force => true do |t|
    t.boolean  "finalized"
    t.boolean  "has_errors"
    t.integer  "reporting_year"
    t.string   "grant_number"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "created_by"
    t.string   "updated_by"
  end

  create_table "data_definitions", :force => true do |t|
    t.string   "name"
    t.text     "definition"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "data_definitions_key_metrics", :id => false, :force => true do |t|
    t.integer "key_metric_id"
    t.integer "data_definition_id"
  end

  create_table "degree_types", :force => true do |t|
    t.string   "type"
    t.string   "name"
    t.string   "abbreviation"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "created_by"
    t.string   "updated_by"
  end

  # unrecognized index "index_degree_types_on_name" with type ActiveRecord::ConnectionAdapters::IndexDefinition
  # unrecognized index "index_degree_types_on_type" with type ActiveRecord::ConnectionAdapters::IndexDefinition

  create_table "departments", :force => true do |t|
    t.string   "name"
    t.integer  "externalid"
    t.string   "entity_name"
    t.string   "school"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "created_by"
    t.string   "updated_by"
  end

  # unrecognized index "index_departments_on_externalid" with type ActiveRecord::ConnectionAdapters::IndexDefinition
  # unrecognized index "index_departments_on_name" with type ActiveRecord::ConnectionAdapters::IndexDefinition

  create_table "dependencies", :force => true do |t|
    t.integer  "question_id"
    t.integer  "question_group_id"
    t.string   "rule"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "created_by"
    t.string   "updated_by"
  end

  create_table "dependency_conditions", :force => true do |t|
    t.integer  "dependency_id"
    t.string   "rule_key"
    t.integer  "question_id"
    t.string   "operator"
    t.integer  "answer_id"
    t.datetime "datetime_value"
    t.integer  "integer_value"
    t.float    "float_value"
    t.string   "unit"
    t.text     "text_value"
    t.string   "string_value"
    t.string   "response_other"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "created_by"
    t.string   "updated_by"
  end

  create_table "ethnic_types", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "created_by"
    t.string   "updated_by"
  end

  # unrecognized index "index_ethnic_types_on_name" with type ActiveRecord::ConnectionAdapters::IndexDefinition

  create_table "institution_positions", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "created_by"
    t.string   "updated_by"
  end

  # unrecognized index "index_institution_positions_on_name" with type ActiveRecord::ConnectionAdapters::IndexDefinition

  create_table "institution_positions_people", :id => false, :force => true do |t|
    t.integer "institution_position_id"
    t.integer "person_id"
  end

  # unrecognized index "institution_positions_people_idx" with type ActiveRecord::ConnectionAdapters::IndexDefinition

  create_table "key_metrics", :force => true do |t|
    t.string   "name"
    t.integer  "organizational_unit_id"
    t.integer  "target_metric_id"
    t.string   "datatype"
    t.text     "note"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "key_metrics_projects", :id => false, :force => true do |t|
    t.integer "key_metric_id"
    t.integer "project_id"
  end

  create_table "notes", :force => true do |t|
    t.text     "text"
    t.integer  "notable_id"
    t.string   "notable_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "organizational_units", :force => true do |t|
    t.string   "name"
    t.string   "abbreviation"
    t.integer  "parent_id"
    t.integer  "lft"
    t.integer  "rgt"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "cc_pers_affiliate_identifier"
    t.string   "created_by"
    t.string   "updated_by"
  end

  # unrecognized index "index_organizational_units_on_name" with type ActiveRecord::ConnectionAdapters::IndexDefinition
  # unrecognized index "index_organizational_units_on_parent_id" with type ActiveRecord::ConnectionAdapters::IndexDefinition

  create_table "organizational_units_people", :id => false, :force => true do |t|
    t.integer "organizational_unit_id"
    t.integer "person_id"
  end

  # unrecognized index "organizational_units_people_idx" with type ActiveRecord::ConnectionAdapters::IndexDefinition

  create_table "organizations", :force => true do |t|
    t.string   "type"
    t.string   "code"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "created_by"
    t.string   "updated_by"
  end

  # unrecognized index "index_organizations_on_code" with type ActiveRecord::ConnectionAdapters::IndexDefinition
  # unrecognized index "index_organizations_on_name" with type ActiveRecord::ConnectionAdapters::IndexDefinition
  # unrecognized index "index_organizations_on_type" with type ActiveRecord::ConnectionAdapters::IndexDefinition

  create_table "outcome_metrics", :force => true do |t|
    t.integer  "activity_id"
    t.integer  "amount"
    t.string   "name"
    t.text     "note"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "participating_organizations", :force => true do |t|
    t.string   "name"
    t.string   "city"
    t.integer  "country_id"
    t.integer  "us_state_id"
    t.integer  "reporting_year"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "ctsa_reporting_years_mask"
  end

  create_table "people", :force => true do |t|
    t.string   "type"
    t.string   "first_name"
    t.string   "middle_name"
    t.string   "last_name"
    t.string   "netid"
    t.string   "email"
    t.string   "department_affiliation"
    t.string   "school_affiliation"
    t.string   "last_four_of_ssn"
    t.string   "phone"
    t.string   "era_commons_username"
    t.string   "employeeid"
    t.integer  "department_id"
    t.string   "personnelid"
    t.string   "address"
    t.string   "city"
    t.string   "state"
    t.boolean  "edited_by_user"
    t.integer  "organizational_unit_id"
    t.integer  "degree_type_one_id"
    t.integer  "degree_type_two_id"
    t.integer  "specialty_id"
    t.integer  "country_id"
    t.integer  "ethnic_type_id"
    t.integer  "race_type_id"
    t.boolean  "disadvantaged_background"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "human_subject_protection_training_institution"
    t.date     "human_subject_protection_training_date"
    t.boolean  "service_rendered",                              :default => false
    t.string   "training_type"
    t.string   "trainee_status"
    t.boolean  "has_disability"
    t.string   "gender"
    t.string   "title"
    t.string   "fax"
    t.boolean  "edited"
    t.boolean  "imported"
    t.integer  "ctsa_reporting_years_mask"
    t.boolean  "system_administrator",                          :default => false
    t.string   "created_by"
    t.string   "updated_by"
    t.string   "mentor_era_commons_username"
    t.date     "appointment_date"
    t.date     "end_date"
  end

  # unrecognized index "index_people_on_country_id" with type ActiveRecord::ConnectionAdapters::IndexDefinition
  # unrecognized index "index_people_on_degree_type_one_id" with type ActiveRecord::ConnectionAdapters::IndexDefinition
  # unrecognized index "index_people_on_degree_type_two_id" with type ActiveRecord::ConnectionAdapters::IndexDefinition
  # unrecognized index "index_people_on_department_id" with type ActiveRecord::ConnectionAdapters::IndexDefinition
  # unrecognized index "index_people_on_employeeid" with type ActiveRecord::ConnectionAdapters::IndexDefinition
  # unrecognized index "index_people_on_era_commons_username" with type ActiveRecord::ConnectionAdapters::IndexDefinition
  # unrecognized index "index_people_on_ethnic_type_id" with type ActiveRecord::ConnectionAdapters::IndexDefinition
  # unrecognized index "index_people_on_organizational_unit_id" with type ActiveRecord::ConnectionAdapters::IndexDefinition
  # unrecognized index "index_people_on_race_type_id" with type ActiveRecord::ConnectionAdapters::IndexDefinition
  # unrecognized index "index_people_on_specialty_id" with type ActiveRecord::ConnectionAdapters::IndexDefinition

  create_table "people_time_entries", :id => false, :force => true do |t|
    t.integer "person_id"
    t.integer "time_entry_id"
  end

  create_table "projects", :force => true do |t|
    t.string   "name"
    t.integer  "organizational_unit_id"
    t.integer  "service_line_id"
    t.datetime "start_at"
    t.datetime "end_at"
    t.boolean  "billable"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "publications", :force => true do |t|
    t.string   "pmcid"
    t.string   "pmid"
    t.string   "nihms_number"
    t.date     "publication_date"
    t.integer  "person_id"
    t.text     "abstract"
    t.string   "title",                     :limit => 1000
    t.boolean  "nucats_assisted"
    t.boolean  "edited_by_user"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "cited"
    t.string   "missing_pmcid_reason"
    t.integer  "ctsa_reporting_years_mask"
    t.string   "created_by"
    t.string   "updated_by"
    t.string   "journal"
    t.integer  "citation_cnt"
  end

  # unrecognized index "index_publications_on_person_id" with type ActiveRecord::ConnectionAdapters::IndexDefinition

  create_table "question_groups", :force => true do |t|
    t.text     "text"
    t.text     "help_text"
    t.string   "reference_identifier"
    t.string   "data_export_identifier"
    t.string   "common_namespace"
    t.string   "common_identifier"
    t.string   "display_type"
    t.string   "custom_class"
    t.string   "custom_renderer"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "created_by"
    t.string   "updated_by"
  end

  create_table "questions", :force => true do |t|
    t.integer  "survey_section_id"
    t.integer  "question_group_id"
    t.text     "text"
    t.text     "short_text"
    t.text     "help_text"
    t.string   "pick"
    t.string   "reference_identifier"
    t.string   "data_export_identifier"
    t.string   "common_namespace"
    t.string   "common_identifier"
    t.integer  "display_order"
    t.string   "display_type"
    t.boolean  "is_mandatory"
    t.integer  "display_width"
    t.string   "custom_class"
    t.string   "custom_renderer"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "correct_answer_id"
    t.string   "created_by"
    t.string   "updated_by"
  end

  create_table "race_types", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "created_by"
    t.string   "updated_by"
  end

  # unrecognized index "index_race_types_on_name" with type ActiveRecord::ConnectionAdapters::IndexDefinition

  create_table "response_sets", :force => true do |t|
    t.integer  "user_id",      :limit => 8
    t.integer  "survey_id",    :limit => 8
    t.string   "access_code"
    t.datetime "started_at"
    t.datetime "completed_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "service_id"
    t.string   "created_by"
    t.string   "updated_by"
  end

  # unrecognized index "response_sets_ac_idx" with type ActiveRecord::ConnectionAdapters::IndexDefinition

  create_table "responses", :force => true do |t|
    t.integer  "response_set_id"
    t.integer  "question_id"
    t.integer  "answer_id"
    t.datetime "datetime_value"
    t.integer  "integer_value"
    t.float    "float_value"
    t.string   "unit"
    t.text     "text_value"
    t.string   "string_value"
    t.string   "response_other"
    t.string   "response_group"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "survey_section_id"
    t.string   "created_by"
    t.string   "updated_by"
  end

  # unrecognized index "index_responses_on_survey_section_id" with type ActiveRecord::ConnectionAdapters::IndexDefinition

  create_table "roles", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "service_lines", :force => true do |t|
    t.string   "name"
    t.integer  "organizational_unit_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "created_by"
    t.string   "updated_by"
  end

  # unrecognized index "index_service_lines_on_name" with type ActiveRecord::ConnectionAdapters::IndexDefinition

  create_table "service_requests", :force => true do |t|
    t.integer  "service_line_id"
    t.integer  "organizational_unit_id"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.string   "project"
    t.text     "abstract"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "services", :force => true do |t|
    t.integer  "service_line_id"
    t.integer  "person_id"
    t.date     "entered_on"
    t.string   "state"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "created_by"
    t.string   "updated_by"
  end

  # unrecognized index "index_services_on_person_id" with type ActiveRecord::ConnectionAdapters::IndexDefinition
  # unrecognized index "index_services_on_service_line_id" with type ActiveRecord::ConnectionAdapters::IndexDefinition

  create_table "specialties", :force => true do |t|
    t.string   "code"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "created_by"
    t.string   "updated_by"
  end

  # unrecognized index "index_specialties_on_code" with type ActiveRecord::ConnectionAdapters::IndexDefinition
  # unrecognized index "index_specialties_on_name" with type ActiveRecord::ConnectionAdapters::IndexDefinition

  create_table "sponsors", :force => true do |t|
    t.string   "name"
    t.string   "code"
    t.string   "sponsor_type_description"
    t.string   "sponsor_type"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "created_by"
    t.string   "updated_by"
  end

  # unrecognized index "index_sponsors_on_code" with type ActiveRecord::ConnectionAdapters::IndexDefinition
  # unrecognized index "index_sponsors_on_name" with type ActiveRecord::ConnectionAdapters::IndexDefinition

  create_table "survey_sections", :force => true do |t|
    t.integer  "survey_id"
    t.string   "title"
    t.text     "description"
    t.string   "reference_identifier"
    t.string   "data_export_identifier"
    t.string   "common_namespace"
    t.string   "common_identifier"
    t.integer  "display_order"
    t.string   "custom_class"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "created_by"
    t.string   "updated_by"
  end

  create_table "surveys", :force => true do |t|
    t.string   "title"
    t.text     "description"
    t.string   "access_code"
    t.string   "reference_identifier"
    t.string   "data_export_identifier"
    t.string   "common_namespace"
    t.string   "common_identifier"
    t.datetime "active_at"
    t.datetime "inactive_at"
    t.string   "css_url"
    t.string   "custom_class"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "display_order"
    t.string   "created_by"
    t.string   "updated_by"
  end

  # unrecognized index "surveys_ac_idx" with type ActiveRecord::ConnectionAdapters::IndexDefinition

  create_table "target_metrics", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.string   "datatype"
    t.integer  "number"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "time_entries", :force => true do |t|
    t.integer  "activity_id"
    t.datetime "start_at"
    t.datetime "end_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "us_states", :force => true do |t|
    t.string   "name"
    t.string   "abbreviation"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "created_by"
    t.string   "updated_by"
  end

  create_table "validation_conditions", :force => true do |t|
    t.integer  "validation_id"
    t.string   "rule_key"
    t.string   "operator"
    t.integer  "question_id"
    t.integer  "answer_id"
    t.datetime "datetime_value"
    t.integer  "integer_value"
    t.float    "float_value"
    t.string   "unit"
    t.text     "text_value"
    t.string   "string_value"
    t.string   "response_other"
    t.string   "regexp"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "created_by"
    t.string   "updated_by"
  end

  create_table "validations", :force => true do |t|
    t.integer  "answer_id"
    t.string   "rule"
    t.string   "message"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "created_by"
    t.string   "updated_by"
  end

  create_table "versions", :force => true do |t|
    t.string   "item_type",  :null => false
    t.integer  "item_id",    :null => false
    t.string   "event",      :null => false
    t.text     "whodunnit"
    t.text     "object"
    t.datetime "created_at"
  end

  # unrecognized index "index_versions_on_item_type_and_item_id" with type ActiveRecord::ConnectionAdapters::IndexDefinition

end
