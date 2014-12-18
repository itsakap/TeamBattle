// custom-select.js
$(document).ready(function() {
  $('select[data-option-dependent=true]').each(function (i) {
    
    var observer_dom_id = $(this).attr('id');
    var observed_dom_id = $(this).data('option-observed');
    var url_mask = $(this).data('option-url');
    var key_method = $(this).data('option-key-method');
    var value_method = $(this).data('option-value-method');
    var regexp = /:[0-9a-zA-Z_]+:/g;
    var observer = $('select#' + observer_dom_id);
    var observed = $('#' + observed_dom_id);
    if (!observer.val() && observed.size() > 1) {
        observer.attr('disabled', true);
    }
    populateOptions();
    function populateOptions(){
      var firstLoad = true;
      if (observed.val()) {
        url = url_mask.replace(regexp, observed.val());
        $.getJSON(url, function (data) {
          $.each(data.legal_targets, function (i, object) {
            observer.attr('disabled', false);
            observer.append($('<option>').attr('value', object[key_method]).text(object[value_method]));
            if(i == 0){
              observer.val(data.current_target ? data.current_target : object[key_method]);
            }
          });
        });
      }  
    }
    observed.on('change',function () {
      observer.empty();
      populateOptions();
    });
  });

});