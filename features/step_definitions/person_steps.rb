Given /^a person already exists with name: "([^"]*)" and netid: "([^"]*)"$/ do |name, netid|
  Factory(:person, :first_name => name.split(' ')[0], :last_name => name.split(' ')[1], :netid => netid)
end

Given /^a role already exists with name: "([^"]*)"$/ do |name|
  Factory(:role, :name => name)
end