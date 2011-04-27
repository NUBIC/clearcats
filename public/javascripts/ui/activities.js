Clearcats.UI.Activities = function (config) {

  var ui = {
    setupActivityTypeAutocompleter: function () {
      $(".activity_type_autocompleter").autocomplete({
        source: config.activityTypesUrl,
        minLength: 3,
        select: function(event, ui) { 
          $('.activity_type_autocompleter').val(ui.item.label);
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
                                                              caller: this }),
  notesNestedAttributesForm = new NestedAttributes({ container: $('.notes'), 
                                                              association: 'notes', 
                                                              content: config.notesTemplate, 
                                                              addHandler: null,
                                                              caller: this });


  ui.setupActivityTypeAutocompleter();
  ui.setupSelectPersonAutocompleter();

  $(".datepicker").datepicker();
  
};
