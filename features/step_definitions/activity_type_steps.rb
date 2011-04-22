Given /^a service_line "(.*)" with these activity_types:$/ do |service_line_name, table|
  svc_line = ServiceLine.create!(:name => service_line_name)
  table.hashes.each do |at|
    ActivityType.create!(:name => at[:name], :service_line => svc_line)
  end
end
