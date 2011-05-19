Clearcats.UI.People = function (config) {

  var ui = {
    setupSpecialtyAutocompleter: function () {
      $("#specialty_autocomplete").autocomplete({
        source: config.specialtiesUrl,
        minLength: 2,
        select: function(event, ui) { 
          $('#specialty_autocomplete').val(ui.item.label);
          $("##{@person.class.to_s.downcase}_specialty_id").val(ui.item.id);
        }
      });
    },
    setupDepartmentAutocompleter: function () {
      $(".department_autocomplete").autocomplete({
        source: config.departmentsUrl,
        minLength: 2,
        select: function(event, ui) { 
          $('.department_autocomplete').val(ui.item.label);
        }
      });
    },
    setupSchoolAutocompleter: function () {
      $(".school_autocomplete").autocomplete({
        source: config.schoolsUrl,
        minLength: 2,
        select: function(event, ui) { 
          $('.school_autocomplete').val(ui.item.label);
        }
      });
    },
  }

  ui.setupSpecialtyAutocompleter();
  ui.setupDepartmentAutocompleter();
  ui.setupSchoolAutocompleter();

  $('#specialty_autocomplete').focus(function(){
    $(this).select();
  });

  $('.department_autocomplete').focus(function(){
    $(this).select();
  });

  $('.school_autocomplete').focus(function(){
    $(this).select();
  });

  $(".help_icon").tooltip();

  $('.search_form_show_toggle').live("click", function() {
    $(this).parent().siblings('#search_form_show').show();
    $(this).closest('#search_form_hide').hide();
  });
  
  $('.search_form_hide_toggle').live("click", function() {
    $(this).parent().siblings('#search_form_hide').show();
    $(this).closest('#search_form_show').hide();
  });

}