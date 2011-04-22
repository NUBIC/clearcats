require 'spec_helper'

describe SpecialtiesController do
  
  context "logged in as administrator" do

    before(:each) do
      login(admin_login)
    end
  
    describe "GET index" do
      it "should render the index page" do
        get :index
        response.should be_success
      end

      it "assigns all specialties as @specialties" do
        s = Factory(:specialty, :name => "q", :code => "c")
        specialties = [s]
        Specialty.should_receive(:all).and_return(specialties)
        get :index, :term => "q", :format => :json
        assigns[:specialties].should == [{"id"=>s.id, "label"=>"c q", "value"=>"c q"}]
      end
    end
  end  
end