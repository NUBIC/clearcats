namespace :maintenance do    
  
  desc "Removes orphaned service records"
  task :delete_orphaned_service_records => :environment do 
    Service.all.select{ |svc| svc.person.nil? }.each { |svc| svc.destroy }
  end
  
end