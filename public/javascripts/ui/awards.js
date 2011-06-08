Clearcats.UI.Awards = function (config) {

  var sortByUrlMap   = config.sortByUrlMap;
  var prefixPath = config.prefixPath;

  $('#sort_awards_by').live("change", function() {
    var that = this,
      value = $(this).val(),
      url = sortByUrlMap[value];
      
    $('#sorting_indicator').show();

    $.get(url, function (data) {
      $(that).closest('#awards').replaceWith(data);
      $('#sort_awards_by').val(value);
      $('#sorting_indicator').hide();
    });
  });

  var onsuccess = function(data) {
    var award_id = data.id
    var url = prefixPath + "/awards/row/" + award_id + "?person_id=" + data.person_id;
    
    // if updating existing record
    if($('div#award_' + award_id).exists()) {
      $('div#award_' + award_id).html('<p>Updating . . .<img src="' + prefixPath + '/images/ajax-loader.gif" alt="Loading"></img></p>');
      $.get(url, null, function (response) {
        $('div#award_' + award_id).replaceWith(response);
      });
    // otherwise creating new record
    } else {
      $('div#new_award').html('<p>Creating new record . . .<img src="' + prefixPath + '/images/ajax-loader.gif" alt="Loading"></img></p>');
      $.get(url, null, function (response) {
        $('form.dirtyform').prepend(response);
        $('div#new_award').html('');
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

  $('.details_view_link').live('click', function() {
  	$('<div id="dialog"/>').appendTo('body').load($(this).attr('href')).dialog({
  	  title: $(this).attr('title'),
      // autoOpen: false,
      height: 650,
      width: 800,
      modal: true,
      buttons: {
        Close: function() {
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
    if(el.attr("selectedIndex") > 0) {
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
    if(el.attr("selectedIndex") > 0) {
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
