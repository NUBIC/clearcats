namespace :scrub do
  
  desc 'Update the services table to set the entered_on attribute'
  task(:services_entered_on => :environment) do
    Service.all.each do |svc|
      svc.update_attribute(:entered_on, svc.created_at.to_date) if svc.entered_on.blank?
    end
  end

end