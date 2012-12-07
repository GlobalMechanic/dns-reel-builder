$(document).ready(function() {
  $reel = $('.reel-id');
  if ($reel.length > 0) {
    var reelID = $reel.attr('id').replace(/reel-/, '');
    $('.clip .reel').click(function(e) {
      var $clip = $(this);
      var clipID = $clip.attr('id').replace(/clip-/, '');
      $clip.toggleClass('add').toggleClass('remove').addClass('loading');
      if ($clip.hasClass('add')) {
        $.get('/reels/' + reelID + '/remove.json', { clip_id: clipID }, function(data) {
          $clip.removeClass('loading');
        });
      }
      else if ($clip.hasClass('remove')) {
        $.get('/reels/' + reelID + '/add.json', { clip_id: clipID }, function(data) {
          $clip.removeClass('loading');
        });
      }
      return false;
    });

    var $dragged = null;
    $('.clip').bind('dragstart', function(e) {
      $('.clips').addClass('dragging');
      $dragged = $(this).addClass('dragged');
      return true;
    }).bind('dragend', function(e) {
      $('.clips').removeClass('dragging');
      $dragged.removeClass('dragged');
      return true;
    });

    $('.slot').bind('dragover', function(e) {
      $(this).addClass('active');
      // Drag into a neighbouring slot (no change).
      if ($dragged.next().get(0) === this || $dragged.prev().get(0) === this) {
        return true;
      }
      else {
        return false;
      }
    }).bind('dragleave', function(e) {
      $(this).removeClass('active');
      return false;
    }).bind('drop', function(e) {
      var $this = $(this);
      var $bringMeAlong = $dragged.prev();

      // Move clip into new slot
      $dragged.insertAfter($this);
      $bringMeAlong.insertAfter($dragged);

      // Remove active from slot.
      $this.removeClass('active');

      // Save new order to server.
      var clips = [];
      $('.clip .reel').each(function(index, clip) {
        clips.push($(clip).attr('id').replace(/clip-/, ''));
      });
      $.post('/reels/' + reelID + '/sort.json', { order: clips }, function(data) {
        // We cool.
      });
    });

  }
  else {
    $('.clip .reel').remove();
  }
});
