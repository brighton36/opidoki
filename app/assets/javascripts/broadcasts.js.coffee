$('document').ready ->
  @errorModal = $('#errors-modal')

  $("#broadcast_closes_at").datetimepicker format: "yyyy-mm-dd hh:ii"

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
      console.log response.address
      $('.flip-container').addClass('hover')
      false
  })
