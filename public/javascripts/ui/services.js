Clearcats.UI.Services = function (config) {

  $(".datepicker").live('mouseover', function() { 
    $(this).datepicker({ maxDate: "0D" }); 
  });

  var approvalsNestedAttributesForm = new NestedAttributes({ container: $('.approvals'), 
                                                             association: 'approvals', 
                                                             content: config.approvalsTemplate, 
                                                             addHandler: null,
                                                             caller: this });
};
