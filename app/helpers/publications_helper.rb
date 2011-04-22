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
      'ascend_by_pmcid'            => url_for_sort(search, :pmcid, "PMCID", :params => params_for_search.merge(options)),
      'descend_by_pmcid'           => url_for_sort(search, :pmcid, "PMCID", :params => params_for_search.merge(options)),
      'ascend_by_pmid'             => url_for_sort(search, :pmid, "PMID", :params => params_for_search.merge(options)),
      'descend_by_pmid'            => url_for_sort(search, :pmid, "PMID", :params => params_for_search.merge(options)),
      'ascend_by_publication_date' => url_for_sort(search, :publication_date, "Publication Date", :params => params_for_search.merge(options)),
      'decend_by_publication_date' => url_for_sort(search, :publication_date, "Publication Date", :params => params_for_search.merge(options)),
      'ascend_by_title'            => url_for_sort(search, :title, "Title", :params => params_for_search.merge(options)),
      'decend_by_title'            => url_for_sort(search, :title, "Title", :params => params_for_search.merge(options)),
    }
  end
  
  def url_for_sort(builder, attribute, *args)
    raise ArgumentError, "Need a MetaSearch::Builder search object as first param!" unless builder.is_a?(MetaSearch::Builder)
    attr_name = attribute.to_s
    name = (args.size > 0 && !args.first.is_a?(Hash)) ? args.shift.to_s : builder.base.human_attribute_name(attr_name)
    prev_attr, prev_order = builder.search_attributes['meta_sort'].to_s.split('.')
    current_order = prev_attr == attr_name ? prev_order : nil
    new_order = current_order == 'asc' ? 'desc' : 'asc'
    options = args.first.is_a?(Hash) ? args.shift : {}
    options.merge!(
      builder.search_key => builder.search_attributes.merge(
        'meta_sort' => [attr_name, new_order].join('.')
      )
    )

    url_for(options)

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
      options[:params_scope] => search.conditions.merge( { :meta_sort => new_scope } )
    }.deep_merge(options[:params] || {})

    options[:as] = raw(options[:as]) if defined?(RailsXss)

    url_for(url_options)
  end

  private
    def params_for_search
      { :person_id => params[:person_id] }
    end
end