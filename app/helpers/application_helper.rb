# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  
  #### NESTED FORMS ####

  # def link_to_soft_delete_fields(name, f, association)
  #   f.hidden_field(:soft_delete) + link_to(name, "javascript:void(0);", :class => "delete_#{association.to_s} delete_link icon_link")
  # end
  
  def link_to_remove_nested_attribute_fields(name, f, association)
    f.hidden_field(:_destroy) + link_to(name, "javascript:void(0);", :class => "delete_#{association.to_s} delete_link icon_link")
  end
  
  def link_to_add_nested_attribute_fields(name, association)
    link_to(name, 'javascript:void(0);', :class => "add_#{association.to_s} add add_link icon_link")
  end

  def generate_nested_attributes_template(f, association, association_prefix = nil )
    if association_prefix.nil?
      association_prefix = association.to_s.singularize
    end
    new_object = f.object.class.reflect_on_association(association).klass.new
    fields = f.fields_for(association, new_object, :child_index => "new_#{association}") do |form_builder|
      render(association_prefix + "_fields", :f => form_builder)
    end
    escape_javascript(fields)
  end

  #### PAGE TITLE ####

  def title(page_title, show_title = true)
    @show_title = show_title
    content_for(:title) { page_title.to_s }
  end

  def show_title?
    @show_title
  end
  
  def session_username
    username = "anonymous"
    if current_user 
      usr = get_current_user
      username = usr.respond_to?(:full_name) ? usr.full_name : usr.username
    end
    username
  end

  #### APPLICATION VERSION ####

  def ctsa_wording
    ctsa_txt = faculty_member? ? "Interacted with NUCATS" : "CTSA Reportable #{SYSTEM_CONFIG['current_ctsa_reporting_year']}"
    ctsa_txt
  end

  def application_version
    return "#{APP_VERSION["major"]}.#{APP_VERSION["minor"]}.#{APP_VERSION["revision"]}" rescue "x.x.x"
  end

  def javascript(*files)
    content_for(:head) { javascript_include_tag(*files) }
  end

  def stylesheet(*files)
    content_for(:head) { stylesheet_link_tag(*files) }
  end
  
  #### VIEW HELPERS ####
  
  def null_safe(val, default = "n/a")
    val.blank? ? default : h(val.to_s)
  end
  
  def has_sub_uri?
    return Rails.env == "staging"
  end
  
  def cc_prefix_path
    has_sub_uri? ? "/clearcats" : ""
  end
  
  def encode_email(email)
    encoded = []
    email.each_char { |c| encoded << "&##{c.ord};" }
    encoded.join("")
  end
  
  ### META SORT ###
  
  def url_for_sort(builder, attribute, order, *args)
    raise ArgumentError, "Need a MetaSearch::Builder search object as first param!" unless builder.is_a?(MetaSearch::Builder)
    attr_name = attribute.to_s
    name = (args.size > 0 && !args.first.is_a?(Hash)) ? args.shift.to_s : builder.base.human_attribute_name(attr_name)
    
    options = args.first.is_a?(Hash) ? args.shift : {}
    options.merge!(
      builder.search_key => builder.search_attributes.merge(
        'meta_sort' => [attr_name, order].join('.')
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

end