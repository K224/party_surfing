# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

window.profile_load_rating = (weight) ->
  $.ajax(url: "/profiles/" + window.profile_id + "/vote?weight=" + weight).done (rating) ->
    div = document.getElementById('rating')
    div.innerHTML = ''
    if rating['host_num'] != 0
      div.innerHTML += '<div class="row">Количество голосов за пользователя в качестве организатора ' +
                       rating['host_num'] + '. Средняя оценка пользователя как организатора ' +
                       rating['host_sum'] / rating['host_num'] + ' / 5.</div>'
    if rating['user_num'] == 0
      div.innerHTML += '<div class="row">Никто не оценивал участие данного пользователя</div>'
    else
      div.innerHTML += '<div class="row">Общее количество голосов ' +
                       rating['user_num'] + '. Средний рейтинг ' +
                       rating['user_sum'] / rating['user_num'] + ' / 5.</div>'
