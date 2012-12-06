$(document).ready(function() {
  $reel = $('.reel-id');
  if ($reel.length > 0) {
    var reelID = $reel.attr('id').replace(/reel-/, '');
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
    });

    var $dragged = null;
    $('.clip').bind('dragstart', function() {
      $('.clips').addClass('dragging');
      $dragged = $(this);
      return true;
    }).bind('dragend', function() {
      $('.clips').removeClass('dragging');
      return true;
    });
    $('.slot').bind('dragover', function(e) {
      // Dragging into current slot.
      if ($dragged.next().get(0) === this || $dragged.prev().get(0) === this) {
        window.event.dataTransfer.dropEffect = 'none';
      }
      else {
        $(this).addClass('active');
      }
      return false;
    }).bind('dragleave', function() {
      $(this).removeClass('active');
      return false;
    }).bind('drop', function(e) {
      //window.tylor = e;
      var $bringMeAlong = $dragged.prev();
      $dragged.insertAfter(this);
      $bringMeAlong.insertAfter($dragged);
      $(this).removeClass('active');

      //var slot = $(this).attr('id').replace(/slot-/, '');
      //console.log(slot);
    });

  }
  else {
    $('.clip .reel').remove();
  }
});
