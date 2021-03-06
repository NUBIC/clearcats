require 'spec_helper'

describe ActivitiesController do

  def mock_activity(stubs={})
    @mock_activity ||= mock_model(Activity, stubs)
  end

  context "with an authenticated user" do
    before(:each) do
      login(user_login)
    end
    
    describe "GET index" do
      it "assigns all activities as @activities" do
        Activity.stub(:search).and_return([mock_activity])
        get :index
        assigns[:activities].should == [mock_activity]
      end
    end
    
    describe "GET new" do
      it "assigns a new activity as @activity" do
        Activity.stub(:new).and_return(mock_activity)
        get :new
        assigns[:activity].should equal(mock_activity)
      end
    end
    
    describe "POST create" do

      describe "with valid params" do
        it "assigns a newly created activity as @activity" do
          Activity.stub(:new).with({'these' => 'params'}).and_return(mock_activity(:save => true))
          post :create, :activity => {:these => 'params'}
          assigns[:activity].should equal(mock_activity)
        end

        it "redirects to the created activity" do
          Activity.stub(:new).and_return(mock_activity(:save => true))
          post :create, :activity => {}
          response.should redirect_to(activities_url)
        end
      end

      describe "with invalid params" do
        it "assigns a newly created but unsaved activity as @activity" do
          Activity.stub(:new).with({'these' => 'params'}).and_return(mock_activity(:save => false))
          post :create, :activity => {:these => 'params'}
          assigns[:activity].should equal(mock_activity)
        end

        it "re-renders the 'new' template" do
          Activity.stub(:new).and_return(mock_activity(:save => false))
          post :create, :activity => {}
          response.should render_template('new')
        end
      end

    end


    describe "POST create from external source" do

      describe "with valid params" do
        it "assigns a newly created activity as @activity" do
          Factory(:person, :netid => "asdf")
          Factory(:project, :name => "pt")
          Factory(:role, :name => "Submitter")
          Activity.stub(:new).and_return(mock_activity(:save => true))
          post :create_from_external_source, :project_title => "pt", :netid => "asdf", :role => "Submitter"
          assigns[:activity].should equal(mock_activity)
        end
      end

    end

    
    describe "GET edit" do
      it "assigns the requested activity as @activity" do
        Activity.stub(:find).with("37").and_return(mock_activity(:contacts => [], :activity_type => nil, :activity_type_id => nil))
        get :edit, :id => "37"
        assigns[:activity].should equal(mock_activity)
      end
    end
    
    describe "PUT update" do
    
      describe "with valid params" do
        it "updates the requested activity" do
          Activity.should_receive(:find).with("37").and_return(mock_activity(:contacts => []))
          mock_activity.should_receive(:update_attributes).with({'these' => 'params'})
          put :update, :id => "37", :activity => {:these => 'params'}
        end
    
        it "assigns the requested activity as @activity" do
          Activity.stub(:find).and_return(mock_activity(:update_attributes => true, :contacts => []))
          put :update, :id => "1"
          assigns[:activity].should equal(mock_activity)
        end
    
        it "redirects to the activity" do
          Activity.stub(:find).and_return(mock_activity(:update_attributes => true, :contacts => []))
          put :update, :id => "1"
          response.should redirect_to(activities_url)
        end
      end
    
      describe "with invalid params" do
        it "updates the requested activity" do
          Activity.should_receive(:find).with("37").and_return(mock_activity(:contacts => []))
          mock_activity.should_receive(:update_attributes).with({'these' => 'params'})
          put :update, :id => "37", :activity => {:these => 'params'}
        end
    
        it "assigns the activity as @activity" do
          Activity.stub(:find).and_return(mock_activity(:update_attributes => false, :contacts => []))
          put :update, :id => "1"
          assigns[:activity].should equal(mock_activity)
        end
    
        it "re-renders the 'edit' template" do
          Activity.stub(:find).and_return(mock_activity(:update_attributes => false, :contacts => []))
          put :update, :id => "1"
          response.should render_template('edit')
        end
      end
    
    end
    
  end
  
end