
$(".help_icon").tooltip();

$('.search_form_show_toggle').live("click", function() {
  $(this).parent().siblings('#search_form_show').show();
  $(this).closest('#search_form_hide').hide();
});

$('.search_form_hide_toggle').live("click", function() {
  $(this).parent().siblings('#search_form_hide').show();
  $(this).closest('#search_form_show').hide();
});