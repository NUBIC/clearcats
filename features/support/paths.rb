module NavigationHelpers
  # Maps a name to a path. Used by the
  #
  #   When /^I go to (.+)$/ do |page_name|
  #
  # step definition in web_steps.rb
  #
  def path_to(page_name)
    case page_name

    when /the home\s?page/
      '/'

    when /login/
      '/login'

    ### SERVICES ###

    when /the service index page/
      services_path
      
    when /the edit service page/
      edit_service_path(Service.last)

    when /the edit service page for person "(.*)" and service line "(.*)"/
      edit_service_path(Service.first(:conditions => { :person => Person.find_by_netid($1), :service_line => ServiceLine.find_by_name($2) }))

    when /the services choose person page/
      choose_person_services_path
      
    when /the service choose person page/
      choose_person_service_path(Service.last)
      
    when /the service choose service line page/
      choose_service_line_service_path(Service.last)

    when /the service identified page/
      identified_service_path(Service.last)
      
    when /the service choose awards page/
      choose_awards_service_path(Service.last)
      
    when /the service choose publications page/
      choose_publications_service_path(Service.last)
      
    when /the service choose approvals page/
      choose_approvals_service_path(Service.last)
    
    when /the my services page/
      "/services/my_services"

    ### PUBLICATIONS ###

    when /the edit publication page for the "(.*)"/
      edit_publication_path(Publication.find_by_title($1))
      
    when /the publications edit page/
      edit_publication_path(Publication.last)
      # edit_publication_path(Publication.first(:order => "updated_at desc"))
      
    when /the publication versions page for "(.*)"/
      versions_publication_path(Publication.find_by_pmid($1))
      
    ### AWARDS ###

    when /the awards edit page/
      edit_award_path(Award.first(:order => "updated_at desc"))
    
    when /the award versions page for "(.*)"/
      versions_award_path(Award.find_by_budget_identifier($1))
    
    when /the awards search page/
      search_awards_path
    
    ### PEOPLE ###
    
    when /the person versions page for "(.*)"/
      versions_person_path(Person.find_by_netid($1))

    when /the person search page/
      people_path
    
    ### APPROVALS ###
      
    when /the approvals search page/
      search_approvals_path
      
    ### SERVICE LINES ###

    when /the service lines page/
      service_lines_path
    
    when /the new service lines page/
      new_service_line_path
      
    when /the service lines edit page/
      edit_service_line_path(ServiceLine.first(:order => "updated_at desc"))

    ### ACTIVITIES ###
    
    when /the new activity page/
      new_activity_path 
      
    ### PROJECTS ###
    
    when /the edit project page/
      edit_project_path(Project.last)
  
    ### KEY METRICS ###

    when /the edit key metric page/
      edit_key_metric_path(KeyMetric.last)
      
    ### CTSA REPORTS ###

    when /the ctsa reports page/
      ctsa_reports_path
      
    ### ADMIN/CTSA DATA ###
    
    when /the activity codes page/
      "/admin/activity_codes"
      
    when /the countries page/
      "/admin/countries"

    when /the non-phs organizations page/
      "/admin/non_phs_organizations"
      
    when /the phs organizations page/
      "/admin/phs_organizations"
      
    when /the specialties page/
      "/admin/specialties"
      
    when /the upload ctsa data page/
      "/admin/upload_ctsa_data"

    ### PARTICIPATING ORGANIZATIONS ###

    when /the participating organizations page/
      participating_organizations_path

    when /the new participating organizations page/
      new_participating_organization_path

    when /the participating organizations edit page/
      edit_participating_organization_path(ParticipatingOrganization.first(:order => "updated_at desc"))

    else
      begin
        page_name =~ /the (.*) page/
        path_components = $1.split(/\s+/)
        self.send(path_components.push('path').join('_').to_sym)
      rescue Object => e
        raise "Can't find mapping from \"#{page_name}\" to a path.\n" +
          "Now, go and add a mapping in #{__FILE__}"
      end
    end
  end
end

World(NavigationHelpers)
