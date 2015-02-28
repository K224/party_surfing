# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

window.init_map = () ->
  map_options = {
    zoom: 10,
    center: new google.maps.LatLng(55.65, 37.67),
    disableDefaultUI: true,
    mapTypeId: google.maps.MapTypeId.ROADMAP
  }
  window.map = new google.maps.Map(document.getElementById('map'), map_options)
  window.markers = []
  input = document.getElementById('searchbox')
  inputDiv = document.getElementById('searchdiv')
  button = document.getElementById('searchbutton')
  if input != null
    map.controls[google.maps.ControlPosition.TOP_LEFT].push(inputDiv)
    searchBox = new google.maps.places.SearchBox(input)
    google.maps.event.addListener(map, 'bounds_changed', () ->
      bounds = map.getBounds()
      searchBox.setBounds(bounds) )
    google.maps.event.addListener(searchBox, 'places_changed', () ->
      places = searchBox.getPlaces()
      if places.length == 0
        return
      bounds = new google.maps.LatLngBounds()
      for place in places
        bounds.extend(place.geometry.location)
      map.fitBounds(bounds) )
    button.onclick = () ->
      location = {address: document.getElementById('searchbox').value}
      geocoder = new google.maps.Geocoder()
      geocoder.geocode(location, (data) ->
        lat = data[0].geometry.location.lat()
        lng = data[0].geometry.location.lng()
        origin = new google.maps.LatLng(lat, lng)
        bounds = new google.maps.LatLngBounds()
        bounds.extend(origin)
        map.fitBounds(bounds) )
  input = document.getElementById('btnSearch')
  if input != null
    map.controls[google.maps.ControlPosition.TOP_LEFT].push(input)

window.init_map_place_selection = () ->
  init_map()
  google.maps.event.addListener(window.map, 'click', (e) ->
    if window.selection_marker?
      window.selection_marker.setMap(null)
    window.selection_marker = new google.maps.Marker({
      position: e.latLng,
      map: window.map
    })
    window.map.panTo(e.latLng)
    foo = document.getElementById('party_coord_latitude')
    foo.value = e.latLng.lat()
    foo = document.getElementById('party_coord_longitude')
    foo.value = e.latLng.lng()
  )

window.load_parties_in_zone = () ->
  for marker in window.markers
    marker.setMap(null)
  window.markers = []
  bounds = window.map.getBounds()
  $.ajax(url: "/parties/get_parties_in_zone?zone="+bounds.toUrlValue()).done (json) ->
    parties = json
    div = document.getElementById('parties')
    div.innerHTML = ""
    if parties.length == 0
      div.innerHTML = "Ничего не найдено в данной области :("
    for party in parties
      content =
        "<div>
          <div>
            <a class='CenTex' href='/parties/#{party.id}'><h3>#{party.title}</h3></a>
            <h5 class='CenTex'>#{party.date}</h5>
            <a href='/parties/#{party.id}'><div class='SRCHcon'><div class='SRCHcen'><img class='miniavatarSRCH' src='#{party.get_thumb_url}'></div></div></a>
            <h5 class='CenTex'>Описание: #{party.summary}</h5>
          </div>
        </div>"
      div.innerHTML += content
      coords = new google.maps.LatLng(party.coord_latitude,
                                      party.coord_longitude)
      marker = new google.maps.Marker({
        position: coords,
        map: window.map,
        content: content
      })
      window.markers.push(marker)
      google.maps.event.addListener marker, 'click', () ->
        if window.infoWindow?
          window.infoWindow.close()
        window.infoWindow = new google.maps.InfoWindow({
          content: this.content
        })
        window.infoWindow.open(window.map, this)


