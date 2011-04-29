Clearcats.UI.ServiceLines = function (config) {

  var activityTypesNestedAttributesForm = new NestedAttributes({ container: $('.activity_types'), 
                                                                 association: 'activity_types', 
                                                                 content: config.activityTypesTemplate, 
                                                                 addHandler: null,
                                                                 caller: this });


   $('.nested_records_activity_types').sortable({
     axis: 'y', 
     dropOnEmpty:false, 
     handle: '.handle', 
     cursor: 'crosshair',
     items: 'li',
     opacity: 0.4,
     scroll: true,
     update: function() {
       $.ajax({
         type: 'post', 
         data: $('.nested_records_activity_types').sortable('serialize') + '&id=' + config.serviceLineId, 
         dataType: 'script', 
         complete: function(request){
             $('.nested_records_activity_types').effect('highlight');
           },
         url: '/activity_types/sort'})
     }
   });
   
   $('.due_dates_and_reminder_fields_toggle').live("click", function() {
     $(this).parent().siblings('.due_dates_and_reminder_fields').show();
     $(this).closest('.due_dates_and_reminder_toggle').hide();
   });

   $('.due_dates_and_reminder_toggle').live("click", function() {
     $(this).parent().siblings('.due_dates_and_reminder_toggle').show();
     $(this).closest('.due_dates_and_reminder_fields').hide();
   });

};
