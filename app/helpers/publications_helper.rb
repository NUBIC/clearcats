module PublicationsHelper
  def options_for_publications_sort_by_select(selected = nil)
    options = []
    options << ['PMCID (ascending)', 'ascend_by_pmcid']
    options << ['PMCID (descending)','descend_by_pmcid']
    options << ['PMID (ascending)', 'ascend_by_pmid']
    options << ['PMID (descending)','descend_by_pmid']
    options << ['Publication Date (ascending)', 'ascend_by_publication_date']
    options << ['Publication Date (descending)', 'descend_by_publication_date']
    options << ['Title (ascending)', 'ascend_by_title']
    options << ['Title (descending)', 'descend_by_title']
    options_for_select(options, selected)
  end

  def publications_sort_by_url_map(search, options = {})
    {
      'ascend_by_pmcid'            => order_by_url(search, :by => :pmcid, :as => "PMCID", :direction  => :ascend, :params => params_for_search.merge(options)),
      'descend_by_pmcid'           => order_by_url(search, :by => :pmcid, :as => "PMCID", :direction => :descend, :params => params_for_search.merge(options)),
      'ascend_by_pmid'             => order_by_url(search, :by => :pmid, :as => "PMID", :direction  => :ascend, :params => params_for_search.merge(options)),
      'descend_by_pmid'            => order_by_url(search, :by => :pmid, :as => "PMID", :direction => :descend, :params => params_for_search.merge(options)),
      'ascend_by_publication_date' => order_by_url(search, :by => :publication_date, :as => "Publication Date", :direction => :ascend, :params => params_for_search.merge(options)),
      'ascend_by_publication_date' => order_by_url(search, :by => :publication_date, :as => "Publication Date", :direction => :descend, :params => params_for_search.merge(options)),
      'ascend_by_title'            => order_by_url(search, :by => :title, :as => "Title", :direction => :ascend, :params => params_for_search.merge(options)),
      'ascend_by_title'            => order_by_url(search, :by => :title, :as => "Title", :direction => :descend, :params => params_for_search.merge(options)),
    }
  end
  
  def order_by_url(search, options = {}, html_options = {})
    options[:params_scope] ||= :search
    if !options[:as]
      id = options[:by].to_s.downcase == "id"
      options[:as] = id ? options[:by].to_s.upcase : options[:by].to_s.humanize
    end
    options[:ascend_scope] ||= "ascend_by_#{options[:by]}"
    options[:descend_scope] ||= "descend_by_#{options[:by]}"
    if options[:direction] == :ascend
      new_scope =  options[:ascend_scope]
    elsif options[:direction] == :descend
      new_scope = options[:descend_scope]
    end

    url_options = {
      options[:params_scope] => search.conditions.merge( { :order => new_scope } )
    }.deep_merge(options[:params] || {})

    options[:as] = raw(options[:as]) if defined?(RailsXss)

    url_for(url_options)
  end

  private
    def params_for_search
      { :person_id => params[:person_id] }
    end
end