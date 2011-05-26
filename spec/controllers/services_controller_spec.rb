require 'spec_helper'

describe ServicesController do

  def mock_service(stubs={})
    @mock_service ||= mock_model(Service, stubs)
  end
  
  context "with an authenticated user" do
    before(:each) do
      login(user_login)
    end

    describe "GET new" do
      it "assigns a new service as @service" do
        Service.stub(:new).and_return(mock_service)
        get :new
        assigns[:service].should equal(mock_service)
      end
    end
        
    describe "POST create" do

      describe "with valid params" do
        it "assigns a newly created service as @service" do
          Service.stub(:new).with({'service_line_id' => '2'}).and_return(mock_service(:save! => true, :created_by= => true, :state => "new", :initiated? => true, :person => true, :service_line => true))
          post :create, :service => {:service_line_id => '2'}
          assigns[:service].should equal(mock_service)
        end
        
        it "redirects to the services new page (since the person is blank)" do
          Service.stub(:new).with({'service_line_id' => '2'}).and_return(mock_service(:save! => true, :created_by= => true, :state => "new", :initiated? => true, :person => nil))
          post :create, :service => {:service_line_id => '2'}
          response.should redirect_to(new_service_path)
        end
        
        it "redirects to the services new page (since the service_line is blank)" do
          Service.stub(:new).with({'service_line_id' => '2'}).and_return(mock_service(:save! => true, :created_by= => true, :state => "new", :initiated? => true, :person => true, :service_line => nil))
          post :create, :service => {:service_line_id => '2'}
          response.should redirect_to(new_service_path)
        end
        
        it "redirects to the services index page" do
          Service.stub(:new).with({'service_line_id' => '2'}).and_return(mock_service(:save! => true, :created_by= => true, :state => "new", :initiated? => true, :person => true, :service_line => true))
          post :create, :service => {:service_line_id => '2'}
          response.should redirect_to(services_path)
        end
      end

      describe "with invalid params" do
        it "assigns a newly created but unsaved activity_type as @activity_type" do
          Service.stub(:new).with({'service_line_id' => '2'}).and_return(mock_service(:save! => false, :created_by= => true))
          post :create, :service => {:service_line_id => '2'}
          assigns[:service].should equal(mock_service)
        end

        it "re-renders the 'new' template" do
          Service.stub(:new).and_return(mock_service(:save! => false, :created_by= => true))
          post :create, :service => {:service_line_id => '2'}
          response.should render_template('new')
        end
      end

    end
    
    describe "DELETE destroy" do
      it "destroys the requested service" do
        Service.should_receive(:find).with("37").and_return(mock_service(:person => mock_model(Person)))
        mock_service.should_receive(:destroy)
        delete :destroy, :id => "37"
      end

      it "redirects to the activity_types list" do
        Service.stub(:find).and_return(mock_service(:destroy => true, :person => mock_model(Person)))
        delete :destroy, :id => "1"
        response.should redirect_to(services_url)
      end
    end
  end
end