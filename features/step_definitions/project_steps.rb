Given /^a service line already exists with name: "([^"]*)"$/ do |name|
  service_line = Factory(:service_line, :name => name)
end

Given /^a project already exists with name: "([^"]*)"$/ do |name|
  project = Factory(:project, :name => name)
end