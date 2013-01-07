$(document).ready(function() {
  
  $('#open-reel, #create-reel').click(function() {
    $(this).parent().toggleClass('open');
    return false;
  });
  $('#create-reel').click(function () {
    $('#reel_title').focus();
  });

});
