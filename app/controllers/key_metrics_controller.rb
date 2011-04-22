class KeyMetricsController < ApplicationController
  permit :Admin, :User
  before_filter :limit_records_on_organizational_units
  
  # GET /key_metrics
  # GET /key_metrics.xml
  def index
    
    @user_organizational_units = determine_org_units_for_user

    params[:search] ||= {}
    usr_org_units = @user_organizational_units.blank? ? [] : @user_organizational_units.collect(&:id)
    params[:search][:organizational_unit_id_eq_any] ||= usr_org_units

    @search = KeyMetric.search(params[:search])
    @key_metrics = @search.paginate(:page => params[:page], :per_page => 20)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @key_metrics }
    end
  end

  # GET /key_metrics/new
  # GET /key_metrics/new.xml
  def new
    
    @user_organizational_units = determine_org_units_for_user
    @key_metric = KeyMetric.new
    if @user_organizational_units.size == 1
      @key_metric.organizational_unit = @user_organizational_units.first
    end
    
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @key_metric }
    end
  end

  # GET /key_metrics/1/edit
  def edit
    @key_metric = KeyMetric.find(params[:id])
  end

  # POST /key_metrics
  # POST /key_metrics.xml
  def create
    @key_metric = KeyMetric.new(params[:key_metric])

    respond_to do |format|
      if @key_metric.save
        format.html { redirect_to(key_metrics_path, :notice => 'Key Metric was successfully created.') }
        format.xml  { render :xml => @key_metric, :status => :created, :location => @key_metric }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @key_metric.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /key_metrics/1
  # PUT /key_metrics/1.xml
  def update
    @key_metric = KeyMetric.find(params[:id])

    respond_to do |format|
      if @key_metric.update_attributes(params[:key_metric])
        format.html { redirect_to(key_metrics_path, :notice => 'Key Metric was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @key_metric.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /key_metrics/1
  # DELETE /key_metrics/1.xml
  def destroy
    @key_metric = KeyMetric.find(params[:id])
    @key_metric.destroy

    respond_to do |format|
      format.html { redirect_to(key_metrics_url) }
      format.xml  { head :ok }
    end
  end
  
  private
  
    def limit_records_on_organizational_units
      @user_organizational_units = determine_organizational_units_for_user
      @service_lines = ServiceLine.for_organizational_units(@user_organizational_units)
      @key_metrics = KeyMetric.for_organizational_units(@user_organizational_units)
    end
end
