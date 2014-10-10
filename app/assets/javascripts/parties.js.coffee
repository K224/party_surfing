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

window.load_parties_in_zone = () ->
  for marker in window.markers
    marker.setMap(null)
  window.markers = []
  bounds = window.map.getBounds()
  $.ajax(url: "/parties/get_parties_in_zone?zone="+bounds.toUrlValue()).done (json) ->
    parties = json
    div = document.getElementById('parties')
    div.innerHTML = ""
    for party in parties
      div.innerHTML +=
        "<div>
          <a href='/parties/#{party.id}'>#{party.title}</a>
          <p>#{party.summary}</p>
        </div>"
      coords = new google.maps.LatLng(party.coord_latitude,
                                      party.coord_longitude)
      window.markers.push new google.maps.Marker({
        position: coords,
        map: window.map
      })


