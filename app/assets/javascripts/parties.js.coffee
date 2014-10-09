# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

window.init_map = () ->
  map_options = {
    zoom: 10,
    center: new google.maps.LatLng(55.65, 37.67),
    disableDefaultUI: true
  }
  window.map = new google.maps.Map(document.getElementById('map'), map_options)

window.load_parties_in_zone = () ->
  bounds = window.map.getBounds()
  $.ajax(url: "/parties/get_parties_in_zone?zone="+bounds.toUrlValue()).done (json) ->
    window.parties = json

