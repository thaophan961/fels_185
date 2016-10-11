$(document).ready ->
  $('#word').on 'change', 'input[type=checkbox]', (e) ->
    $('.answers_checkbox').removeAttr('checked')
    @checked = true

