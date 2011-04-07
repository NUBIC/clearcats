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
    
    setupSelectPersonAutocompleter: function () {
      $(".person_select_autocompleter").autocomplete({
        source: config.selectPeopleUrl,
        minLength: 3,
        select: function(event, ui) { 
          var identifier = '#' + this.id;
          $(identifier.replace('select', 'id')).val(ui.item.id);
        }
      });
    },
  },
  activityActorsNestedAttributesForm = new NestedAttributes({ container: $('.activity_actors'), 
                                                              association: 'activity_actors', 
                                                              content: config.activityActorsTemplate, 
                                                              addHandler: ui.setupSelectPersonAutocompleter, 
                                                              caller: this });

  ui.setupActivityTypeAutocompleter();
  ui.setupSelectPersonAutocompleter();

  $(".datepicker").datepicker();
  
};
