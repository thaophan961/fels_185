$(document).ready ->
  numberOfCorrectAnswer = $('p#correct').length
  $('#correct_count').html numberOfCorrectAnswer
  $('input[type=radio]').change ->
    numberOfCheckedRadio = $('input:radio:checked').length
    $('#answer_count').html numberOfCheckedRadio
