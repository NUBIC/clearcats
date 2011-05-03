Clearcats.UI.Services = function (config) {

    
  $("a.menu_nav").dirty_stopper();
  $(".help_icon").tooltip();
  $("form").dirty_form();  
  
  $('#specialty_autocomplete').focus(function(){
    $(this).select();
  });
  $('#specialty_autocomplete').autocomplete({
    source: "#{specialties_path(:format => :json)}",
    minLength: 2,
    select: function(event, ui) { 
      $('#specialty_autocomplete').val(ui.item.label);
      $("##{@person.class.to_s.downcase}_specialty_id").val(ui.item.id);
    }
  });

  $(".datepicker").live('mouseover', function() { 
    $(this).datepicker({ maxDate: config.maxDate }); 
  });

  var approvalsNestedAttributesForm = new NestedAttributes({ container: $('.approvals'), 
                                                             association: 'approvals', 
                                                             content: config.approvalsTemplate, 
                                                             addHandler: null,
                                                             caller: this });
};
