Clearcats.UI.ServiceLines = function (config) {

  var activityTypesNestedAttributesForm = new NestedAttributes({ container: $('.activity_types'), 
                                                                 association: 'activity_types', 
                                                                 content: config.activityTypesTemplate, 
                                                                 addHandler: null,
                                                                 caller: this });
};
