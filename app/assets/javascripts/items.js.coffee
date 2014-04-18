jQuery ->
  $('#js-items').sortable
    update: ->
      $.post($(this).data('update-url'), $(this).sortable('serialize'))