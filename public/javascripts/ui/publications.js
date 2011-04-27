Clearcats.UI.Publications = function (config) {

  var sortByUrlMap = config.sortByUrlMap;

  $('.truncated_publication_abstract_toggle').live("click", function() {
    $(this).parent().siblings('.publication_abstract').show();
    $(this).closest('.truncated_publication_abstract').hide();
  });

  $('.publication_abstract_toggle').live("click", function() {
    $(this).parent().siblings('.truncated_publication_abstract').show();
    $(this).closest('.publication_abstract').hide();
  });


  $('#sort_publications_by').live("change", function() {
    var that = this,
      value = $(this).val(),
      url = sortByUrlMap[value];

    $.get(url, function (data) {
      $(that).closest('#publications').replaceWith(data);
      $('#sort_publications_by').val(value);
    });
  });

    

  var onsuccess = function(data) {
    $('div#publication_' + data.id).html('<p>Updating . . .<img src="/images/ajax-loader.gif" alt="Loading"></img></p>');
    var publication_id = data.id
    var url = "/publications/row/" + publication_id + "?person_id=" + data.person_id;
    $.get(url, null, function (response) {
      $('div#publication_' + publication_id).replaceWith(response);
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

  $(".datepicker").live('mouseover', function() { $(this).datepicker(); }); 
  $("form").dirty_form();
  $("a.menu_nav").dirty_stopper();
  $.DirtyForm.dynamic = true

};
