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
    
  end
  
end