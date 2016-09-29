$(document).ready ->
  $('input[type=radio]').change ->
    numberOfCheckedRadio = $('input:radio:checked').length
    $('#answer_count').html numberOfCheckedRadio
