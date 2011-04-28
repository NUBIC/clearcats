require 'spec_helper'

describe ServiceRequestsController do

  def mock_service_request(stubs={})
    @mock_service_request ||= mock_model(ServiceRequest, stubs)
  end

  context "with an authenticated user" do
    before(:each) do
      login(user_login)
    end
    
    describe "GET index" do
      it "assigns all service_requests as @service_requests" do
        ServiceRequest.stub(:all).and_return([mock_service_request])
        get :index
        assigns[:service_requests].should == [mock_service_request]
      end
    end
    
    describe "GET new" do
      it "assigns a new service_request as @service_request" do
        ServiceRequest.stub(:new).and_return(mock_service_request)
        get :new
        assigns[:service_request].should equal(mock_service_request)
      end
    end
    
    describe "POST create" do

      describe "with valid params" do
        it "assigns a newly created service_request as @service_request" do
          ServiceRequest.stub(:new).with({'these' => 'params'}).and_return(mock_service_request(:save => true))
          post :create, :service_request => {:these => 'params'}
          assigns[:service_request].should equal(mock_service_request)
        end

        it "redirects to the created service_request" do
          ServiceRequest.stub(:new).and_return(mock_service_request(:save => true))
          post :create, :service_request => {}
          response.should redirect_to(service_request_path(mock_service_request))
        end
      end

      describe "with invalid params" do
        it "assigns a newly created but unsaved service_request as @service_request" do
          ServiceRequest.stub(:new).with({'these' => 'params'}).and_return(mock_service_request(:save => false))
          post :create, :service_request => {:these => 'params'}
          assigns[:service_request].should equal(mock_service_request)
        end

        it "re-renders the 'new' template" do
          ServiceRequest.stub(:new).and_return(mock_service_request(:save => false))
          post :create, :service_request => {}
          response.should render_template('new')
        end
      end

    end
    
    describe "GET edit" do
      it "assigns the requested service_request as @service_request" do
        ServiceRequest.stub(:find).with("37").and_return(mock_service_request(:contacts => []))
        get :edit, :id => "37"
        assigns[:service_request].should equal(mock_service_request)
      end
    end
    
    describe "PUT update" do
    
      describe "with valid params" do
        it "updates the requested service_request" do
          ServiceRequest.should_receive(:find).with("37").and_return(mock_service_request(:contacts => []))
          mock_service_request.should_receive(:update_attributes).with({'these' => 'params'})
          put :update, :id => "37", :service_request => {:these => 'params'}
        end
    
        it "assigns the requested service_request as @service_request" do
          ServiceRequest.stub(:find).and_return(mock_service_request(:update_attributes => true, :contacts => []))
          put :update, :id => "1"
          assigns[:service_request].should equal(mock_service_request)
        end
    
        it "redirects to the service_request" do
          ServiceRequest.stub(:find).and_return(mock_service_request(:update_attributes => true, :contacts => []))
          put :update, :id => "1"
          response.should redirect_to(service_request_path(mock_service_request))
        end
      end
    
      describe "with invalid params" do
        it "updates the requested service_request" do
          ServiceRequest.should_receive(:find).with("37").and_return(mock_service_request(:contacts => []))
          mock_service_request.should_receive(:update_attributes).with({'these' => 'params'})
          put :update, :id => "37", :service_request => {:these => 'params'}
        end
    
        it "assigns the service_request as @service_request" do
          ServiceRequest.stub(:find).and_return(mock_service_request(:update_attributes => false, :contacts => []))
          put :update, :id => "1"
          assigns[:service_request].should equal(mock_service_request)
        end
    
        it "re-renders the 'edit' template" do
          ServiceRequest.stub(:find).and_return(mock_service_request(:update_attributes => false, :contacts => []))
          put :update, :id => "1"
          response.should render_template('edit')
        end
      end
    
    end
    
  end
  
end