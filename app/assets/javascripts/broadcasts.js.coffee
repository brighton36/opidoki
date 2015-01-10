$('document').ready ->
  @errorModal = $('#errors-modal')
  
  $('#new_broadcast').ajaxForm({
    dataType: 'json',
    error: (xhr, xhrStatus) ->
      $('#errors-modal .modal-body').html('')
      response = jQuery.parseJSON(xhr.responseText)
      $('#errors-modal .modal-body').append(response.errors)
      $('#errors-modal').modal()
      false
    success: (plainObject, xhrStatus, xhr) ->
      console.log 'success'
      response = jQuery.parseJSON(xhr.responseText)
      console.log response
      false
  })

showRequest = (formData, jqForm, options) ->
  queryString = $.param(formData)
  lert "About to submit: \n\n" + queryString
  
  # here we could return false to prevent the form from being submitted; 
  # returning anything other than false will allow the form submit to continue 
  true
