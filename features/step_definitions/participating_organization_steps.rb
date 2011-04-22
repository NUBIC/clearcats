Given /^a participating organization already exists with name: "([^"]*)"$/ do |name|
  Factory(:participating_organization, :name => name)
end