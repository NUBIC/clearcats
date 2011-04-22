Clearcats.AwardsUI = function (config) {

  var onsuccess = function(data) {
    $('tr#award_' + data.id).html('<p>Updating . . .<img src="/images/ajax-loader.gif" alt="Loading"></img></p>');
    var award_id = data.id
    var url = "/awards/row/" + award_id + "?person_id=" + data.person_id;
    $.get(url, null, function (response) {
      $('tr#award_' + award_id).html(response);
    });
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
              onsuccess(response);
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
  
  $('#award_phs_organization_id').live('change', function() {
    el = $('#award_phs_organization_id');
    if(el.selectedIndex > 0) {
      $('#award_activity_code_id').attr('disabled', '');
      $('#award_non_phs_organization_id').attr('disabled', 'disabled');
    } else {
      $('#award_activity_code_id').val('');
      $('#award_activity_code_id').attr('disabled', 'disabled');
      $('#award_non_phs_organization_id').attr('disabled', '');
    }
  });
  
  $('#award_non_phs_organization_id').live('change', function() {
    el = $('#award_non_phs_organization_id');
    if(el.selectedIndex > 0) {
      $('#award_activity_code_id').val('');
      $('#award_activity_code_id').attr('disabled', 'disabled');
      $('#award_phs_organization_id').attr('disabled', 'disabled');
    } else {
      $('#award_activity_code_id').attr('disabled', '');
      $('#award_phs_organization_id').attr('disabled', '');
    }
  });
  
  $(".datepicker").live('mouseover', function() { $(this).datepicker(); }); 
  $("form").dirty_form();
  $("a.menu_nav").dirty_stopper();
  $.DirtyForm.dynamic = true
  
  
};
