Clearcats.UI.Services = function (config) {

  $('.show_notes_toggle').live("click", function() {
    $(this).parent().siblings('.notes_section').show();
    $(this).closest('.notes_toggle').hide();
  });

  $('.hide_notes_toggle').live("click", function() {
    $(this).parent().siblings('.notes_toggle').show();
    $(this).closest('.notes_section').hide();
  });

  var onsvcsuccess = function(data) {
    var activity_id = data.id
    var service_id = data.service_id
    var url = "/services/" + service_id + "/activity?activity_id=" + activity_id;
    
    // if updating existing record
    if($('div#activity_' + activity_id).exists()) {
      $('div#activity_' + activity_id).html('<p>Updating . . .<img src="/images/ajax-loader.gif" alt="Loading"></img></p>');
      $.get(url, null, function (response) {
        $('div#activity_' + activity_id).replaceWith(response);
      });
    // otherwise creating new record
    } else {
      $('div#new_activity').html('<p>Creating new record . . .<img src="/images/ajax-loader.gif" alt="Loading"></img></p>');
      $.get(url, null, function (response) {
        $('.activities').append('<div class="page_section span-24">' + response + '</div');
        $('div#new_activity').html('');
      });
    }
    $('#dialog').remove();
  }

  $('.edit_modal_form_link').live('click', function() {
  	$('<div id="dialog"/>').appendTo('body').load($(this).attr('href') + ' form').dialog({
  	  title: $(this).attr('title'),
      // autoOpen: false,
      height: 650,
      width: 800,
      modal: true,
      buttons: {
        Save: function() {
          var url = $("#modal_edit_form").attr('action');
          var dlg = $(this);
          $.ajax({
            type: 'POST',
            url: url,
            data: $("#modal_edit_form").serializeArray(),
            dataType: 'json',
            success: function(response) {
              onsvcsuccess(response);
              dlg.dialog('close');
            }
          });
        },
        Cancel: function() {
          $(this).dialog('close')
        }
      },
      close: function() {

      }

  	});
  	return false;
  });


    
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
