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
  
  $("#activity_service_line_id").live("change", function() {
    $("#activity_type_select").show();
    
    svc_line_id = $("#activity_service_line_id").val();
    $.ajax({
      type: "GET",
      url: "/activity_types/options.json",
      data: "search[service_line_id_eq]=" + svc_line_id,
      success: function(j) {
        if (j.length > 0) {
          var options = '<option value="">-- Select Activity Type --</option>';
          for (var i = 0; i < j.length; i++) {
            options += '<option value="' + j[i].value + '">' + j[i].label + '</option>';
          }
          $("select#activity_activity_type_id").html(options);
        } else {
          $("select#activity_activity_type_id").html('<option value="">No Activity Types are associated with Service Line</option>')
        }
      }
    });
  });
  
};
