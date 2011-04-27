Clearcats.UI.CTSAReports = function (config) {

  var attachmentsNestedAttributesForm = new NestedAttributes({ container: $('.attachments'), 
                                                               association: 'attachments', 
                                                               content: config.attachmentsTemplate, 
                                                               addHandler: null,
                                                               caller: this });
};
