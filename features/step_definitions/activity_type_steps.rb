Given /^a service_line "(.*)" with these activity_types:$/ do |name, table|
  svc_line = Factory(:service_line, :name => name)
  table.hashes.each do |at|
    Factory(:activity_type, :service_line => svc_line, :name => at[:name])
  end
end