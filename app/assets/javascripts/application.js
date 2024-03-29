// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require tabs
//= require zero-clipboard
//= require clips
//= require reel

$(document).ready(function() {

  // Dynamic search form.
  var nameToId = {
    'all': '#search_title_or_client_or_director_or_description_or_category_or_keywords_taggings_tag_name_contains',
    'title': '#search_title_contains',
    'director': '#search_director_equals',
    'category': '#search_category_equals',
    'client': '#search_client_equals',
    'technique': '#search_techniques_taggings_tag_name_contains',
    'keyword': '#search_keywords_taggings_tag_name_contains'
  };

  // Make 'All' field active if no search criteria.
  if ($(nameToId['all']).hasClass('show') && $(nameToId['all']).val() == '') {
    $(nameToId['all']).focus();
  }

  // Show and hide search facets.
  $('#clip_search #where').change(function(e) {
    $('#clip_search .facet').removeClass('show');
    $(nameToId[$(this).val()]).addClass('show').focus();
  });

  $('#clip_search select.facet').change(function(e) {
    $('#clip_search').submit();
  });

  // Remove inactive search facets before submitting.
  $('#clip_search').submit(function() {
    $('#clip_search .facet').not(nameToId[$('#clip_search #where').val()]).remove();
  });

});
