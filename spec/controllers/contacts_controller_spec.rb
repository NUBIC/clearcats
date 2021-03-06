require 'spec_helper'

describe ContactsController do
  def mock_contact(stubs={})
    @mock_contact ||= mock_model(Contact, stubs)
  end

  context "logged in as administrator" do

    before(:each) do
      login(admin_login)
    end

    describe "GET index" do
      it "should render the index page" do
        get :index
        response.should be_success
      end
  
      it "assigns all contacts as @contacts" do
        Contact.stub_chain(:search, :paginate).and_return([mock_contact])
        get :index
        assigns[:contacts].should == [mock_contact]
      end
    end
    
    describe "GET new" do
      it "assigns a new contact as @contact" do
        Contact.stub(:new).and_return(mock_contact)
        get :new
        assigns[:contact].should equal(mock_contact)
      end
    end

    describe "POST create" do

      describe "with valid params" do
        it "assigns a newly created contact as @contact" do
          Contact.stub(:new).with({'these' => 'params'}).and_return(mock_contact(:save => true))
          post :create, :contact => {:these => 'params'}
          assigns[:contact].should equal(mock_contact)
        end

        it "redirects to the created contact" do
          Contact.stub(:new).and_return(mock_contact(:save => true))
          post :create, :contact => {}
          response.should redirect_to(contacts_path)
        end
      end

      describe "with invalid params" do
        it "assigns a newly created but unsaved contact as @contact" do
          Contact.stub(:new).with({'these' => 'params'}).and_return(mock_contact(:save => false))
          post :create, :contact => {:these => 'params'}
          assigns[:contact].should equal(mock_contact)
        end

        it "re-renders the 'new' template" do
          Contact.stub(:new).and_return(mock_contact(:save => false))
          post :create, :contact => {}
          response.should render_template('new')
        end
        
        it "re-renders the new template if a contact already exists with that email address" do
          email = "asdf@asdf.asdf"
          Factory(:contact, :email => email)
          post :create, :contact => { :email => email }
          flash[:link_warning].should_not be_blank
          response.should render_template('new')
        end
        
      end

    end
    
    describe "GET edit" do
      it "assigns the requested contact as @contact" do
        Contact.stub(:find).with("37").and_return(mock_contact)
        get :edit, :id => "37"
        assigns[:contact].should equal(mock_contact)
      end
    end

    describe "PUT update" do

      describe "with valid params" do
        it "updates the requested contact" do
          Contact.should_receive(:find).with("37").and_return(mock_contact)
          mock_contact.should_receive(:update_attributes).with({'these' => 'params'})
          put :update, :id => "37", :contact => {:these => 'params'}
        end

        it "assigns the requested contact as @contact" do
          Contact.stub(:find).and_return(mock_contact(:update_attributes => true))
          put :update, :id => "1"
          assigns[:contact].should equal(mock_contact)
        end

        it "redirects to the contact" do
          Contact.stub(:find).and_return(mock_contact(:update_attributes => true))
          put :update, :id => "1"
          response.should redirect_to(contacts_url)
        end
      end

      describe "with invalid params" do
        it "updates the requested contact" do
          Contact.should_receive(:find).with("37").and_return(mock_contact)
          mock_contact.should_receive(:update_attributes).with({'these' => 'params'})
          put :update, :id => "37", :contact => {:these => 'params'}
        end

        it "assigns the contact as @contact" do
          Contact.stub(:find).and_return(mock_contact(:update_attributes => false))
          put :update, :id => "1"
          assigns[:contact].should equal(mock_contact)
        end

        it "re-renders the 'edit' template" do
          Contact.stub(:find).and_return(mock_contact(:update_attributes => false))
          put :update, :id => "1"
          response.should render_template('edit')
        end
      end

    end
    
    describe "DELETE destroy" do
      it "destroys the requested contact" do
        Contact.should_receive(:find).with("37").and_return(mock_contact)
        mock_contact.should_receive(:destroy)
        delete :destroy, :id => "37"
      end

      it "redirects to the contact list" do
        Contact.stub(:find).and_return(mock_contact(:destroy => true))
        delete :destroy, :id => "1"
        response.should redirect_to(contacts_url)
      end
    end
    
    describe "POST upload" do
      
      describe "with valid params" do
        it "redirects to the contacts_path" do
          controller.stub!(:set_user_organizational_units).and_return(true)
          OrganizationalUnit.should_receive(:find).with("37").and_return(mock_model(OrganizationalUnit))
          Contact.stub!(:import_data).and_return(true)
          mock_file = mock(File, :open => true)
          post :upload, :organizational_unit_id => "37", :file => mock_file
          response.should redirect_to(contacts_path)
        end
      end
      
      describe "with invalid params" do
        it "lets the user know that an org_unit is required" do
          mock_file = mock(File, :open => true)
          post :upload, :file => mock_file
          flash[:link_warning].should == "You cannot upload contacts outside the context of an organizational unit. <br />Please Select an Organizational Unit."
        end
      
        it "redirects to the upload_contacts_path" do
          mock_file = mock(File, :open => true)
          post :upload, :file => mock_file
          response.should redirect_to(upload_contacts_path)
        end
      end
    end
    
  end
end