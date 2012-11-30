$(document).ready(function() {
  var reelID = $('.reel-id').attr('id').replace(/reel-/, '');
  $('.clip .reel').click(function() {
    var $clip = $(this);
    var clipID = $clip.attr('id').replace(/clip-/, '');
    $clip.toggleClass('add').toggleClass('remove').addClass('loading');
    if ($clip.hasClass('add')) {
      $.get('/reels/' + reelID + '/remove.json', { clip_id: clipID }, function(data) {
        console.log(data);
        $clip.removeClass('loading');
      });
    }
    else if ($clip.hasClass('remove')) {
      $.get('/reels/' + reelID + '/add.json', { clip_id: clipID }, function(data) {
        console.log(data);
        $clip.removeClass('loading');
      });
    }
    return false;
  })
});
