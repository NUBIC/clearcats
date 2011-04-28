module PublicationsHelper
  def options_for_publications_sort_by_select(selected = nil)
    options = []
    options << ['-- Sort By --', '']
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
      'ascend_by_pmcid'            => url_for_sort(search, :pmcid, "asc", params_for_search.merge(options)),
      'descend_by_pmcid'           => url_for_sort(search, :pmcid, "desc", params_for_search.merge(options)),
      'ascend_by_pmid'             => url_for_sort(search, :pmid, "asc", params_for_search.merge(options)),
      'descend_by_pmid'            => url_for_sort(search, :pmid, "desc", params_for_search.merge(options)),
      'ascend_by_publication_date' => url_for_sort(search, :publication_date, "asc", params_for_search.merge(options)),
      'decend_by_publication_date' => url_for_sort(search, :publication_date, "desc", params_for_search.merge(options)),
      'ascend_by_title'            => url_for_sort(search, :title, "asc", params_for_search.merge(options)),
      'decend_by_title'            => url_for_sort(search, :title, "desc", params_for_search.merge(options)),
    }
  end

  private
    def params_for_search
      { :person_id => params[:person_id] }
    end
end