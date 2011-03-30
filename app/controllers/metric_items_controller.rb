class MetricItemsController < ApplicationController
  permit :Admin

  # GET /metric_items
  # GET /metric_items.xml
  def index
    params[:search] ||= {}
    @search = MetricItem.search(params[:search])
    @metric_items = @search.paginate(:page => params[:page], :per_page => 20)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @metric_items }
    end
  end

  # GET /metric_items/1
  # GET /metric_items/1.xml
  def show
    @metric_item = MetricItem.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @metric_item }
    end
  end

  # GET /metric_items/new
  # GET /metric_items/new.xml
  def new
    @metric_item = MetricItem.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @metric_item }
    end
  end

  # GET /metric_items/1/edit
  def edit
    @metric_item = MetricItem.find(params[:id])
  end

  # POST /metric_items
  # POST /metric_items.xml
  def create
    @metric_item = MetricItem.new(params[:metric_item])

    respond_to do |format|
      if @metric_item.save
        format.html { redirect_to(metric_items_path, :notice => 'Metric Item was successfully created.') }
        format.xml  { render :xml => @metric_item, :status => :created, :location => @metric_item }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @metric_item.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /metric_items/1
  # PUT /metric_items/1.xml
  def update
    @metric_item = MetricItem.find(params[:id])

    respond_to do |format|
      if @metric_item.update_attributes(params[:metric_item])
        format.html { redirect_to(metric_items_path, :notice => 'Metric was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @metric_item.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /metric_items/1
  # DELETE /metric_items/1.xml
  def destroy
    @metric_item = MetricItem.find(params[:id])
    @metric_item.destroy

    respond_to do |format|
      format.html { redirect_to(metric_items_url) }
      format.xml  { head :ok }
    end
  end
end
