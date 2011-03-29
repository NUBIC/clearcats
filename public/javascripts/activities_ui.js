Clearcats.ActivitiesUI = function (config) {

  var ui = {
    setupActivityTypeAutocompleter: function () {
      $(".activity_type_autocompleter").autocomplete({
        source: config.activityTypesUrl,
        minLength: 3,
        select: function(event, ui) { 
          $('.department_autocomplete').val(ui.item.label);
        }
      });
    },
  }

  ui.setupActivityTypeAutocompleter();

  $(".datepicker").datepicker();
};
