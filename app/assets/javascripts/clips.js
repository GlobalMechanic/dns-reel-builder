$(document).ready(function() {

  // Clip add/remove click events.
  $('.clip .reel').click(function(e) {
    var $clip = $(this);
    $clip.toggleClass('add').toggleClass('remove').addClass('loading');
    if ($clip.hasClass('add')) {
      $.ajax({
        url: $clip.attr('href') + '.json',
        type: 'DELETE',
        success: function(data) {
          if (data > 0) {
            $('#empty-reel').removeClass('show');
            $('#create-reel').addClass('show');
          }
          else {
            $('#empty-reel').addClass('show');
            $('#create-reel').removeClass('show'); 
          }
          $clip.removeClass('loading');
        }
      });
    }
    else if ($clip.hasClass('remove')) {
      $.ajax({
        url: $clip.attr('href') + '.json',
        type: 'POST',
        success: function(data) {
          if (data > 0) {
            $('#empty-reel').removeClass('show');
            $('#create-reel').addClass('show');
          }
          else {
            $('#empty-reel').addClass('show');
            $('#create-reel').removeClass('show'); 
          }
          $clip.removeClass('loading');
        }
      });
    }
    return false;
  });

  $('.clip .default, .clip .title').click(function(e) {
    if ($(this).parents('.clip').hasClass('open')) {
      $(this).parents('.clip').removeClass('open');
      $(this).parent().find('video').each(function() {
        this.pause();
        if (this.currentTime > 0) {
          this.currentTime = 0;
        }
      });
    }
    else {
      $('.clip.open video').each(function () {
          this.pause();
          if (this.currentTime > 0) {
            this.currentTime = 0;
          }
      });
      $('.clip.open').removeClass('open');
      $(this).parents('.clip').addClass('open');
      $(this).parent().find('video').get(0).play();
    }
  });

});
