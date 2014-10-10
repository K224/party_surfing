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
  window.markers = []
  window.infoWindows = []

window.load_parties_in_zone = () ->
  for marker in window.markers
    marker.setMap(null)
  window.markers = []
  window.infoWindows = []
  bounds = window.map.getBounds()
  $.ajax(url: "/parties/get_parties_in_zone?zone="+bounds.toUrlValue()).done (json) ->
    parties = json
    div = document.getElementById('parties')
    div.innerHTML = ""
    for party in parties
      content =
        "<div style='min-width:300px'>
          <a href='/parties/#{party.id}'><h3>#{party.title}</h3></a>
          <p>#{party.summary}</p>
        </div>"
      div.innerHTML += content
      coords = new google.maps.LatLng(party.coord_latitude,
                                      party.coord_longitude)
      window.markers.push (marker = new google.maps.Marker({
        position: coords,
        map: window.map
      }) )
      window.infoWindows.push (infoWindow = new google.maps.InfoWindow({
        content: content
      }) )
      google.maps.event.addListener marker, 'click', () ->
        infoWindow.open(window.map, marker)


