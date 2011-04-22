Given /^an activity code already exists with name: "([^"]*)" and code: "([^"]*)"$/ do |name, code|
  Factory(:activity_code, :code => code, :name => name)
end

Given /^a country already exists with name: "([^"]*)"$/ do |name|
  Factory(:country, :name => name)
end

Given /^a non-phs organization already exists with name: "([^"]*)" and code: "([^"]*)"$/ do |name, code|
  Factory(:non_phs_organization, :code => code, :name => name)
end

Given /^a phs organization already exists with name: "([^"]*)" and code: "([^"]*)"$/ do |name, code|
  Factory(:phs_organization, :code => code, :name => name)
end

Given /^a specialty already exists with name: "([^"]*)" and code: "([^"]*)"$/ do |name, code|
  Factory(:specialty, :code => code, :name => name)
end

When /^I upload a file with valid data$/ do
  attach_file(:attachment_data, File.join(Rails.root, 'features', 'upload_files', 'ctsa_data.xsd'))
  click_button "Upload"
end

