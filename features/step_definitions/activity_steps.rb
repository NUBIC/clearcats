
Given /^an activity type already exists with name: "([^"]*)"$/ do |name|
  organizational_unit = Factory(:organizational_unit)
  service_line = Factory(:service_line, :organizational_unit => organizational_unit)
  activity_type = Factory(:activity_type, :service_line => service_line, :name => name)
end

Given /^an activity already exists with name: "([^"]*)"$/ do |name|
  activity = Factory(:activity, :name => name)
end

When(/^I select the first option in the autocomplete$/) do
  page.find(:css, "ul.ui-autocomplete li:first").click
end
