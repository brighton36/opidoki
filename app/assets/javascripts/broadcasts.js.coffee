$('document').ready ->
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

      address = response.address
      amount = response.amount
      label = response.label

      if address and amount
        # Adjust partial
        $('#address').html(address)
        $('#qrcode').qrcode
          render: "div"
          width: 400
          height: 400
          color: "#3a3"
          text: "bitcoin:#{address}?amount=#{amount}&label=#{label}"

        # Flip animation
        $('.flip-container').addClass('hover')
      else
        $('#errors-modal .modal-body').html('')
        $('#errors-modal .modal-body').append('Error creating QR code')
        $('#errors-modal').modal()
      false
  })
