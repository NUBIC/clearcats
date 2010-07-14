require 'spec_helper'

describe FacultyWebService do
  
  context "calling the faculty web service" do
    context "locating faculty" do
      it "should locate faculty members by netid" do
        FacultyWebService.stub!(:make_request).and_return(netid_response)
        results = FacultyWebService.locate({:netid => "wakibbe"})
        results.should_not be_nil
        results.size.should == 1
        result = results.first
        result.class.should == Person
        result.first_name.should == "Warren"
        result.interests.class.should == Array
        result.interests.first.should == "Bioinformatics"
      end
    
      it "should return a single person" do
        FacultyWebService.stub!(:make_request).and_return(netid_response)
        result = FacultyWebService.locate_one({:netid => "wakibbe"})
        result.class.should == Person
        result.first_name.should == "Warren"
        result.interests.class.should == Array
        result.interests.first.should == "Bioinformatics"
      end
    
      it "should return nil if no one found" do
        FacultyWebService.stub!(:make_request).and_return([])
        result = FacultyWebService.locate_one({:netid => "bad netid"})
        result.should be_nil
      end
    
      it "should locate faculty members by last name" do
        FacultyWebService.stub!(:make_request).and_return(last_name_response)
        results = FacultyWebService.locate({:last_name => "Friedman"})
        results.should_not be_nil
        results.size.should == 6
        results.first.last_name.should == "Friedman"
      end
    
      it "should list all faculty members" do
        FacultyWebService.stub!(:make_request).and_return(last_name_response)
        results = FacultyWebService.locate({:last_name => nil, :netid => nil})
        results.should_not be_nil
        results.size.should == 6
        results.first.last_name.should == "Friedman"
      end
    
      it "should catch any exception and return no results" do
        FacultyWebService.stub!(:make_request).and_raise(Exception.new("test web service exception"))
        results = FacultyWebService.locate({:last_name => nil, :netid => nil})
        results.should be_empty
      end
    end
    
    context "awards and grantmakers" do
      it "should locate all the organizations that have given awards to NU Faculty" do
        FacultyWebService.stub!(:make_request).and_return(organizations_response)
        results = FacultyWebService.award_organizations
        results.should_not be_nil
        results.size.should == 12
        result = results.first
        result.class.should == Organization
        result.name.should == "3M Company"
      end
      
      it "should catch any exception and return no results" do
        FacultyWebService.stub!(:make_request).and_raise(Exception.new("test web service exception"))
        results = FacultyWebService.award_organizations
        results.should be_empty
      end
    end
  end
end

def netid_response
  body = '{"interests":["Bioinformatics","Biomedical ontologies","Genomics","Information Systems","Medical Informatics"],"campus":"Chicago","descriptions":["Biomedical Ontologies, Informatics, Bioinformatics, basic and clinical data representation"],"dv_abbr":"NUCATS","basis":"FT","category":"Research","dept_id":"420000","career_track":"Research","degree":"PhD","division":{"picture_dir":null,"dv_abbr":"NUCATS","dept_id":"420000","label_name":"NUCATS","center_flag":1,"dv_room_number":"11th floor","dv_location_id":"0.101E3","appoint_flag":1,"dv_phone":"312-503-1709","dv_url":"http://www.nucats.northwestern.edu/index.html","dv_name":"Northwestern University Clinical and Translational Sciences Institute (NUCATS)","dv_campus_id":"0.1E1","search_name":"NUCATS","division_id":"420010","sau_id":null,"dv_type":"Clinical"},"joint":[],"rank":"Res Assoc Prof","employee_id":"1018461","division_id":"420010","netid":"wakibbe","pmids":[1657962,3100052,11825185,12613351,14681407,14681427,15114363,15306695,15582151,16277761,16299224,16307524,16314072,16381903,16610959,16820428,17090585,17342793,17443163,17452344,17540033,17634620,18178591,18314582,18467348,18974179,19478018,19594883],"last_name":"Kibbe","centers":["Ctr for Genetic Medicine","NUCATS"],"secondary":["Ctr for Genetic Medicine"],"email":"wakibbe@northwestern.edu","middle_name":"A","first_name":"Warren"}'
  resp = mock_model(Net::HTTPOK, :body => body)
  return resp
end

def last_name_response
  body = '[{"campus":"Chicago","dv_abbr":"Med-General Internal Med","basis":"FT","category":"Regular","dept_id":"307000","career_track":"Clinician","degree":"MD","rank":"Asst Prof","employee_id":"1053631","division_id":"307110","netid":"jfr285","last_name":"Friedman","email":null,"middle_name":null,"first_name":"Jordana"},{"campus":"ENH","dv_abbr":"Psychiatry","basis":"CS","category":"Regular","dept_id":"318000","career_track":"Clinician for CS or PT","degree":"PhD","rank":"Asst Prof, CL","employee_id":"1005825","division_id":"318010","netid":"jbk698","last_name":"Friedman","email":null,"middle_name":"K","first_name":"Julie"},{"campus":"Off Campus","dv_abbr":"Psychiatry","basis":"CS","category":"Regular","dept_id":"318000","career_track":"Clinician for CS or PT","degree":"PhD","rank":"Assoc Prof, CL","employee_id":"1006440","division_id":"318010","netid":"aff224","last_name":"Friedman","email":null,"middle_name":"F","first_name":"Alan"},{"campus":"Chicago","dv_abbr":"Ob/Gyn","basis":"CS","category":"Regular","dept_id":"310000","career_track":"Clinician for CS or PT","degree":"MD","rank":"Instructor, CL","employee_id":"1048977","division_id":"310010","netid":"jlf682","last_name":"Friedman","email":null,"middle_name":"L","first_name":"Jennifer"},{"campus":"Off Campus","dv_abbr":"Psychiatry","basis":"CS","category":"Regular","dept_id":"318000","career_track":"Clinician for CS or PT","degree":"PhD","rank":"Associate, CL","employee_id":"1000456","division_id":"318010","netid":"jaf930","last_name":"Friedman","email":null,"middle_name":"A","first_name":"John"},{"campus":"Off Campus","dv_abbr":"Pediatrics","basis":"CS","category":"Regular","dept_id":"316000","career_track":"Clinician for CS or PT","degree":"MD","rank":"Instructor, CL","employee_id":"1066242","division_id":"316010","netid":"asf217","last_name":"Friedman","email":null,"middle_name":"S","first_name":"Arie"}]'
  resp = mock_model(Net::HTTPOK, :body => body)
  return resp
end

def organizations_response
  body = '[{"name":"3M Company"},{"name":"AAI Corporation"},{"name":"ACCESS Medical Group Ltd."},{"name":"ACTELION Ltd."},{"name":"ADMA Biologics Inc."},{"name":"AECOM Consult Inc."},{"name":"AGA Medical Corporation"},{"name":"AGI Dermatics Inc."},{"name":"AIDS Prevention Initiative Nigeria Ltd./Gte."},{"name":"AIDS Research Alliance - Chicago"},{"name":"ALS Society of Canada"},{"name":"ALS Therapy Alliance Inc."}]'
  resp = mock_model(Net::HTTPOK, :body => body)
  return resp
end