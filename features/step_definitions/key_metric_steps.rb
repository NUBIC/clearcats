Given /^a key metric already exists with name: "([^"]*)"$/ do |name|
  km = Factory(:key_metric, :name => name)
end