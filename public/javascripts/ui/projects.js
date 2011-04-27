Clearcats.UI.Projects = function (config) {

  $("#project_organizational_unit_id").live("change", function() {
    org_unit_id = $("#project_organizational_unit_id").val();
    $.ajax({
      type: "GET",
      url: "/service_lines.json",
      data: "search[organizational_unit_id_eq_any]=" + org_unit_id,
      success: function(j) {
        var options = '<option value="">-- Select Service Line --</option>';
        for (var i = 0; i < j.length; i++) {
          options += '<option value="' + j[i].value + '">' + j[i].label + '</option>';
        }
        $("select#project_service_line_id").html(options);
      }
    });
  });
  
  var keyMetricsNestedAttributesForm = new NestedAttributes({ container: $('.key_metrics'), 
                                                              association: 'key_metrics', 
                                                              content: config.keyMetricsTemplate, 
                                                              addHandler: null,
                                                              caller: this });
                                                                 
  var notesNestedAttributesForm = new NestedAttributes({ container: $('.notes'), 
                                                         association: 'notes', 
                                                         content: config.notesTemplate, 
                                                         addHandler: null,
                                                         caller: this });
};
