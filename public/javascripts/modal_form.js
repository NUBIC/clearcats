$('.edit_modal_form_link').live('click', function() {
	$('<div id="dialog"/>').appendTo('body').load($(this).attr('href') + ' form').dialog({
	  title: $(this).attr('title'),
    // autoOpen: false,
    height: 650,
    width: 800,
    modal: true,
    buttons: {
      Save: function() {
        url  = $("#modal_edit_form").attr('action');
        data = $("#modal_edit_form").serializeArray();
        var dlg = $(this);
        $.ajax({
          type: 'POST',
          url: url,
          data: data,
          dataType: 'json',
          success: function(data) {
            // alert(data.id)
            // console.log(data);
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
