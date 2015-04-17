# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

window.profile_load_rating = (weight) ->
  $.ajax(url: "/profiles/" + window.profile_id + "/vote?weight=" + weight).done (rating) ->
    div = document.getElementById('rating')
    org_rating = 0
    if rating['host_num'] != 0
      org_rating = rating['host_sum'] / rating['host_num']
    part_rating = 0
    if rating['user_num'] != 0
      part_rating = rating['user_sum'] / rating['user_num']
    new_rating_html = '<div class="row">'
    new_rating_html += 'Организатор: '
    for i in [1..5]
      if i <= org_rating
        new_rating_html += '<span class="glyphicon glyphicon-star active-stars stars"></span>'
      else
        new_rating_html += '<span class="glyphicon glyphicon-star-empty stars"></span>'
    new_rating_html += '(' + rating['host_num'].toString() + ')'
    new_rating_html += '</div>'
    new_rating_html += '<div class="row">'
    new_rating_html += 'Участник: '
    for i in [1..5]
      if i <= part_rating
        new_rating_html += '<span class="glyphicon glyphicon-star active-stars stars" onclick="window.profile_load_rating(' + i.toString() + ')"></span>'
      else
        new_rating_html += '<span class="glyphicon glyphicon-star-empty active-stars stars" onclick="window.profile_load_rating(' + i.toString() + ')"></span>'
    new_rating_html += '(' + rating['user_num'].toString() + ')'
    new_rating_html += '</div>'
    if rating['user_num'] == 0
      new_rating_html += '<div class="row">Никто не оценивал участие данного пользователя</div>'
    div.innerHTML = new_rating_html
