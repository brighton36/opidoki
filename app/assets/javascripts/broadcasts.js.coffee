$('document').ready ->
  hljs.initHighlightingOnLoad()

  if $('#new_broadcast').length > 0
    document.forms['new_broadcast'].reset()

    # Select EST as default TimeZone
    $("#closes_at_zone option:contains('(GMT-05:00) Eastern Time (US & Canada)')").each ->
      $(this).attr "selected", "selected"
      return false
    
    $("#broadcast_closes_at").datetimepicker format: "yyyy-mm-dd hh:ii"

    $('#new_broadcast').ajaxForm({
      dataType: 'json',
      beforeSubmit: ->
        $('.fa-spinner').show()
      error: (xhr, xhrStatus) ->
        $('.fa-spinner').hide()
        $('#errors-modal .modal-body .errors').html('')
        response = jQuery.parseJSON(xhr.responseText)
        console.log response.errors
        for error in response.errors
          $('#errors-modal .modal-body .errors').append("<li>#{error}</li>")

        $('#errors-modal').modal()
        false
      success: (plainObject, xhrStatus, xhr) ->
        response = jQuery.parseJSON(xhr.responseText)
        broadcastId = response.broadcast.id
        address = response.broadcast.btc_public_address
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
          setTimeout ( ->
            $('.fa-spinner').hide()
            $('.flip-container').addClass('hover')
            checkFunding broadcastId
          ), 1500
        else
          $('#errors-modal .modal-body').html('')
          $('#errors-modal .modal-body').append('Error creating QR code')
          $('#errors-modal').modal()
        false
    })

checkFunding = (id) ->
  $.ajax({
    url: "/broadcasts/#{id}",
    dataType: 'json',
    success: (plainObject, xhrStatus, xhr) ->
      response = jQuery.parseJSON(xhr.responseText)
      if response.broadcast is "true"
        window.location.href = "/broadcasts/#{id}"
  })
  setTimeout ( ->
    checkFunding(id)
  ), 2000

