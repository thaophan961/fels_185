function changeStatus(checkbox){
  if($(checkbox).prop('checked')){
    $(checkbox).val('true');
  }
  else{
    $(checkbox).val('false');
  }
  $(checkbox).closest('form').submit();
}
