module SurveyorControllerCustomMethods
  def self.included(base)
    # base.send :before_filter, :require_user   # AuthLogic
    # base.send :before_filter, :login_required  # Restful Authentication
    # base.send :layout, 'surveyor_custom'
  end

  # Actions
  def new
    super
    # @title = "You can take these surveys"
  end
  def create
    super
  end
  def show
    super
  end
  def edit
    super
  end
  def update
    super
  end
  
  # Paths
  def surveyor_index
    # most of the above actions redirect to this method
    super # available_surveys_path
  end
  def surveyor_finish
    # the update action redirects to this method if given params[:finish]
    super # available_surveys_path
  end
  
  def get_current_user
    person = find_person_by_current_user
    @current_user = person.nil? ? current_user : person
  end
  
end
class SurveyorController < ApplicationController
  include Surveyor::SurveyorControllerMethods
  include SurveyorControllerCustomMethods
  
  layout 'application'
  
end
