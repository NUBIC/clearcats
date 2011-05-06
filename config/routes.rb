Clearcats::Application.routes.draw do

  match 'reports' => 'reports'
  match '/people/departments' => 'people#departments', :as => :departments
  match '/people/schools' => 'people#schools', :as => :schools

  resources :activity_types do
    collection do
      post :sort
      get :options
    end
  end
  resources :activities do
    member do
      post :create_from_external_source
    end
  end
  resources :projects
  resources :key_metrics
  resources :metric_items
  
  resources :awards, :except => [:destroy] do
    collection do
      post :update_ctsa_reporting_year
      get :search
      get :incomplete
    end
    member do
      get :versions
      get :details
      post :revert
      get :row
    end
  end

  resources :ctsa_reports, :except => [:show] do  
    member do
      get :download
      get :irb_iacuc_report
      get :technology_transfer_report
    end
  end

  resources :publications, :only => [:edit, :update, :new, :create] do
    collection do
      post :update_ctsa_reporting_year
      get :search
      get :incomplete
    end
    member do
      get :versions
      post :revert
      get :row
    end
  end

  resources :approvals, :only => [:index] do
    collection do
      post :update_approvals
      get :search
    end
  end

  resources :organizational_units
  resources :service_requests
  resources :services do
    collection do
      get :chart
      get :choose_person
      get :my_services
      get :choose_service_line
    end
    member do
      get :choose_action
      post :create_service_for_person
      get :choose_person
      get :choose_awards
      put :update_approvals
      put :update_person
      get :choose_organizational_units
      get :identified
      put :identified
      get :continue
      put :continue
      get :choose_publications
      get :surveyable
      get :choose_approvals
      post :survey
      get :choose_service_line
      get :activities
      get :activity
      get :edit_activity
      put :update_activity
      get :new_activity
      post :create_activity
    end
  end

  resources :people do
    member do
      get :versions
      get :version
      post :revert
      get :merge
      post :merge
      get :new_services
      post :create_services
    end
    collection do
      get :upload
      post :upload
      get :search
      post :search
      get :search_results
      post :search_results
      get :select
      post :select
      get :directory
      post :directory
      get :incomplete
      post :update_ctsa_reporting_year
      get :era_commons_username_search
      post :directory
    end
    resources :awards
    resources :publications
    resources :approvals
    resources :services
  end

  resources :clients, :controller => "people"
  resources :contacts do
    collection do
      get :email_search
      get :load_contact
      get :sample_upload_file
      get :upload
      post :upload
    end
  end

  resources :contact_lists
  resources :participating_organizations
  resources :service_lines
  resources :specialties, :only => [:index]
  resources :users, :except => [:destroy, :show]
  resources :roles, :except => [:destroy, :show]
  root :to => "welcome#index"
  
  match 'reports/:action' => 'reports#index'
  
  match '/' => 'welcome#index'
  match '/:controller(/:action(/:id))'
end
