Clearcats.UI.Approvals = function (config) {

  $(".datepicker").live('mouseover', function() { 
    $(this).datepicker({ maxDate: "0D" }); 
  });
  
  $("form").dirty_form();
  $("a.menu_nav").dirty_stopper();
  $("input").live('focus', function() { $(this).closest('form').dirty_form(); });
  $("select").live('focus', function() { $(this).closest('form').dirty_form(); });
  $("a.menu_nav").live('focus', function() { $(this).dirty_stopper(); });
  
  var approvalsNestedAttributesForm = new NestedAttributes({ container: $('.approvals'), 
                                                             association: 'approvals', 
                                                             content: config.approvalsTemplate, 
                                                             addHandler: null,
                                                             caller: this });
};
