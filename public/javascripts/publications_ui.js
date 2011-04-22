Clearcats.PublicationsUI = function (config) {

  var sortByUrlMap = config.sortByUrlMap;

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
    $('tr#publication_' + data.id).html('<p>Updating . . .<img src="/images/ajax-loader.gif" alt="Loading"></img></p>');
    var publication_id = data.id
    var url = "/publications/row/" + publication_id + "?person_id=" + data.person_id;
    $.get(url, null, function (response) {
      $('tr#publication_' + publication_id).html(response);
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
