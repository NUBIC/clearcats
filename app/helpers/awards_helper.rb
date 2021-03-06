module AwardsHelper
  def options_for_awards_sort_by_select(selected = nil)
    options = []
    options << ['-- Sort By --', '']
    options << ['Sponsor (ascending)', 'ascend_by_sponsor_name']
    options << ['Sponsor (descending)','descend_by_sponsor_name']
    options << ['Sponsor Award Number (ascending)', 'ascend_by_sponsor_award_number']
    options << ['Sponsor Award Number (descending)','descend_by_sponsor_award_number']
    options << ['Grant Title (ascending)', 'ascend_by_grant_title']
    options << ['Grant Title (descending)','decend_by_grant_title']
    options << ['Budget Number (ascending)', 'ascend_by_budget_number']
    options << ['Budget Number (descending)','decend_by_budget_number']
    options << ['Project Start Date (ascending)', 'ascend_by_project_period_start_date']
    options << ['Project Start Date (descending)','decend_by_project_period_start_date']
    options << ['Project End Date (ascending)', 'ascend_by_project_period_end_date']
    options << ['Project End Date (descending)','decend_by_project_period_end_date']
    options_for_select(options, selected)
  end

  def awards_sort_by_url_map(search, options = {})
    {
      'ascend_by_sponsor_name'          => url_for_sort(search, :sponsor_name, "asc", params_for_search.merge(options)),
      'descend_by_sponsor_name'         => url_for_sort(search, :sponsor_name, "desc", params_for_search.merge(options)),
      'ascend_by_sponsor_award_number'  => url_for_sort(search, :sponsor_award_number, "asc", params_for_search.merge(options)),
      'descend_by_sponsor_award_number' => url_for_sort(search, :sponsor_award_number, "desc", params_for_search.merge(options)),
      'ascend_by_grant_title'           => url_for_sort(search, :grant_title, "asc", params_for_search.merge(options)),
      'decend_by_grant_title'           => url_for_sort(search, :grant_title, "desc", params_for_search.merge(options)),
      'ascend_by_budget_number'         => url_for_sort(search, :budget_number, "asc", params_for_search.merge(options)),
      'decend_by_budget_number'         => url_for_sort(search, :budget_number, "desc", params_for_search.merge(options)),
      'ascend_by_project_period_start_date' => url_for_sort(search, :project_period_start_date, "asc", params_for_search.merge(options)),
      'decend_by_project_period_start_date' => url_for_sort(search, :project_period_start_date, "desc", params_for_search.merge(options)),
      'ascend_by_project_period_end_date' => url_for_sort(search, :project_period_end_date, "asc", params_for_search.merge(options)),
      'decend_by_project_period_end_date' => url_for_sort(search, :project_period_end_date, "desc", params_for_search.merge(options)),
    }
  end

  private
    def params_for_search
      { :person_id => params[:person_id] }
    end
end