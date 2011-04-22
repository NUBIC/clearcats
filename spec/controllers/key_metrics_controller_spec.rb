require 'spec_helper'

describe KeyMetricsController do

  def mock_key_metric(stubs={})
    @mock_key_metric ||= mock_model(KeyMetric, stubs)
  end

  context "with an authenticated user" do
    before(:each) do
      login(user_login)
    end
    
    describe "GET index" do
      it "assigns all key_metrics as @key_metrics" do
        KeyMetric.stub(:search).and_return([mock_key_metric])
        get :index
        assigns[:key_metrics].should == [mock_key_metric]
      end
    end

    describe "GET new" do
      it "assigns a new key_metric as @key_metric" do
        KeyMetric.stub(:new).and_return(mock_key_metric)
        get :new
        assigns[:key_metric].should equal(mock_key_metric)
      end
    end

    describe "GET edit" do
      it "assigns the requested key_metric as @key_metric" do
        KeyMetric.stub(:find).with("37").and_return(mock_key_metric)
        get :edit, :id => "37"
        assigns[:key_metric].should equal(mock_key_metric)
      end
    end

    describe "POST create" do

      describe "with valid params" do
        it "assigns a newly created key_metric as @key_metric" do
          KeyMetric.stub(:new).with({'these' => 'params'}).and_return(mock_key_metric(:save => true))
          post :create, :key_metric => {:these => 'params'}
          assigns[:key_metric].should equal(mock_key_metric)
        end

        it "redirects to the index" do
          KeyMetric.stub(:new).and_return(mock_key_metric(:save => true))
          post :create, :key_metric => {}
          response.should redirect_to(key_metrics_url)
        end
      end

      describe "with invalid params" do
        it "assigns a newly created but unsaved key_metric as @key_metric" do
          KeyMetric.stub(:new).with({'these' => 'params'}).and_return(mock_key_metric(:save => false))
          post :create, :key_metric => {:these => 'params'}
          assigns[:key_metric].should equal(mock_key_metric)
        end

        it "re-renders the 'new' template" do
          KeyMetric.stub(:new).and_return(mock_key_metric(:save => false))
          post :create, :key_metric => {}
          response.should render_template('new')
        end
      end

    end

    describe "PUT update" do

      describe "with valid params" do
        it "updates the requested key_metric" do
          KeyMetric.should_receive(:find).with("37").and_return(mock_key_metric)
          mock_key_metric.should_receive(:update_attributes).with({'these' => 'params'})
          put :update, :id => "37", :key_metric => {:these => 'params'}
        end

        it "assigns the requested key_metric as @key_metric" do
          KeyMetric.stub(:find).and_return(mock_key_metric(:update_attributes => true))
          put :update, :id => "1"
          assigns[:key_metric].should equal(mock_key_metric)
        end

        it "redirects to the index" do
          KeyMetric.stub(:find).and_return(mock_key_metric(:update_attributes => true))
          put :update, :id => "1"
          response.should redirect_to(key_metrics_url)
        end
      end

      describe "with invalid params" do
        it "updates the requested key_metric" do
          KeyMetric.should_receive(:find).with("37").and_return(mock_key_metric)
          mock_key_metric.should_receive(:update_attributes).with({'these' => 'params'})
          put :update, :id => "37", :key_metric => {:these => 'params'}
        end

        it "assigns the key_metric as @key_metric" do
          KeyMetric.stub(:find).and_return(mock_key_metric(:update_attributes => false))
          put :update, :id => "1"
          assigns[:key_metric].should equal(mock_key_metric)
        end

        it "re-renders the 'edit' template" do
          KeyMetric.stub(:find).and_return(mock_key_metric(:update_attributes => false))
          put :update, :id => "1"
          response.should render_template('edit')
        end
      end

    end

    describe "DELETE destroy" do
      it "destroys the requested key_metric" do
        KeyMetric.should_receive(:find).with("37").and_return(mock_key_metric)
        mock_key_metric.should_receive(:destroy)
        delete :destroy, :id => "37"
      end

      it "redirects to the key_metrics list" do
        KeyMetric.stub(:find).and_return(mock_key_metric(:destroy => true))
        delete :destroy, :id => "1"
        response.should redirect_to(key_metrics_url)
      end
    end
  end
end
