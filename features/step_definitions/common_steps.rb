require 'uri'
require 'cgi'
require File.expand_path(File.join(File.dirname(__FILE__), "..", "support", "paths"))
require File.expand_path(File.join(File.dirname(__FILE__), "..", "support", "selectors"))

When /^I wait (\d+) seconds$/ do |wait_seconds|
  sleep(wait_seconds.to_i)
end

When /^I click on the "([^"]*)" autocomplete option$/ do |link_text|
  # this should work in future versions but not currently stable
  # page.evaluate_script %Q{ $('.ui-menu-item a:contains("#{link_text}")').trigger("mouseenter").click(); }
  page.driver.browser.execute_script %Q{ $('.ui-menu-item a:contains("#{link_text}")').trigger("mouseenter").click(); }
end

Given /^the following (.+) records:$/ do |factory, table|
  table.hashes.each do |hash|
    Factory(factory.to_sym, hash)
  end
end

Then /"(.*)" should appear before "(.*)"/ do |first_item, second_item|
  page.body.should =~ /#{first_item}.*#{second_item}/m
end

Then /^the "(.*)" field should be set to today$/ do |field|
  field = find_field(field)
  field.value.should == Date.today.strftime("%m/%d/%Y")
end