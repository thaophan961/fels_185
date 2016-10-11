function remove_fields(link) {
  $(link).prev('input[type=hidden]').value = '1';
  $(link).closest('.form-group').remove();
}

function add_fields(link, association, content) {
  numberOfAnswerField = $('.choice_question').length
  if (numberOfAnswerField >= 6) {
    alert("Maximum of Answer is 6");
    return;
  }
  var new_id = new Date().getTime();
  var regexp = new RegExp('new_' + association, 'g')
  $(link).parent().before(content.replace(regexp, new_id));
}
