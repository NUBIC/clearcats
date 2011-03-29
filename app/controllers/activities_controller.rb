class ActivitiesController < ApplicationController
  permit :Admin, :User

  def new
    @activity = Activity.new

    respond_to do |format|
      format.html # new.html.haml
      format.xml  { render :xml => @activity }
    end
  end

  def create
    @activity = Activity.new(params[:activity])

    respond_to do |format|
      if @activity.save
        flash[:notice] = 'Activity was successfully created.'
        format.html { redirect_to(@activity) }
        format.xml  { render :xml => @activity, :status => :created, :location => @activity }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @activity.errors, :status => :unprocessable_entity }
      end
    end
  end

end