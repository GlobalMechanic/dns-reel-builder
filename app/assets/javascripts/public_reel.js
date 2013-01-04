//= require jquery
//= require jquery_ujs
//= require underscore
//= require zero-clipboard

$(document).ready(function() {
  var tray = _.template(
    ['<div id="tray-<%= clip.id %>" class="video tray">',
      '<div class="inside">',
        '<video class="video-js vjs-default-skin" controls="controls" autoplay="autoplay" data-setup="{}" width="960" height="540">',
          '<source src="http://globalmechanic.com/clip/movies/<%= clip.video %>" type="video/mp4">',
        '</video>',
        '<div class="meta">',
          '<div class="info">',
            '<ul>',
              '<li><strong>Director</strong> <%= clip.director %></li>',
              '<li><strong>Title</strong> <%= clip.title %></li>',
              '<li><strong>Client</strong> <%= clip.client %></li>',
            '</ul>',
          '</div>',
          '<div class="actions">',
            '<ul>',
              '<li><a href="mailto:tina@globalmechanic.com?subject=Montage%203D"><div class="icon email"></div><div>Contact Us</div></a></li>',
              '<li><a id="share-button" href="#"><div class="icon"></div><div>Share clip</div></a></li>',
            '</ul>',
          '</div>',
          '<div id="share" class="clearfix">',
            '<div class="column">',
              '<label for="share-url">URL for this clip:</label>',
              '<input id="share-url" type="text" value="<%= root_url %>reels/<%= reel.slug %>" /><span class="clippy"></span>',
            '</div>',
            '<div class="column">',
              '<label>Share it with:</label>',
              '<a class="twitter" target="_blank" href="http://twitter.com/share?url=<%= root_url %>reels/<%= reel.slug %>&amp;text=Reel%20from%20Global%20Mechanic%3A%20<%= reel.title %>">Twitter</a>',
              '<a class="email" href="mailto:?subject=Clip%20from%20Global%20Mechanic%3A%20Montage%203D&amp;body=http%3A%2F%2Fglobalmechanic.com%2Freel%2F1204%2F613">Email</a>',
              '<a class="facebook" target="_blank" href="http://www.facebook.com/sharer.php?u=http%3A%2F%2Fglobalmechanic.com%2Freel%2F1204%2F613&amp;t=Clip%20from%20Global%20Mechanic%3A%20Montage%203D">Facebook</a>',
            '</div>',
          '</div>',
          '<div class="description"><%= clip.description %></div>',
        '</div>',
      '</div>',
    '</div>'].join('')
  );

  $('body.public-reel .clips .clip').click(function() {
    var active = $(this).hasClass('active');
    $('body.public-reel .clips .clip.active').removeClass('active');
    $('body.public-reel .video.tray').remove();
    if (!active) {
      $(this).addClass('active');
      var clipID = parseInt($(this).attr('id').replace('clip-', ''));
      $(this).parent('.clips').after(tray({ root_url: gm.root_url, clip: gm.clips[clipID], reel: gm.reel }));
    }
    return false;
  });

});
