$('document').ready ->
  @errorModal = $('#errors-modal')
  @test_addr = "mh6SNGA3HtusbeysegUFDQxBAJiRNBuopZ"
  @amount = "0.0036" # in BTC $1 USD
  @label = "opidoki"

  $('#qrcode').qrcode
    render: "div"
    width: 400
    height: 400
    color: "#3a3"
    text: "bitcoin:#{@test_addr}?amount=#{@amount}&label=#{@label}
  
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
