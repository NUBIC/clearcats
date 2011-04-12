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
};