# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

window.init_map = () ->
  init_tag_field()
  map_options = {
    zoom: 10,
    minZoom: 10,
    maxZoom: 16,
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
      map.fitBounds(bounds)
      zoomChangeBoundsListener = google.maps.event.addListenerOnce(map, 'bounds_changed', (event) ->
        if this.getZoom()
          this.setZoom(16) )
      setTimeout(() ->
        google.maps.event.removeListener(zoomChangeBoundsListener)
      , 2000)
      if autoloadParties == true
        load_parties_in_zone() )
    button.onclick = () ->
      location = {address: document.getElementById('searchbox').value}
      geocoder = new google.maps.Geocoder()
      geocoder.geocode(location, (data) ->
        lat = data[0].geometry.location.lat()
        lng = data[0].geometry.location.lng()
        origin = new google.maps.LatLng(lat, lng)
        bounds = new google.maps.LatLngBounds()
        bounds.extend(origin)
        map.fitBounds(bounds)
        zoomChangeBoundsListener = google.maps.event.addListenerOnce(map, 'bounds_changed', (event) ->
          if this.getZoom()
            this.setZoom(13) )
        setTimeout(() ->
          google.maps.event.removeListener(zoomChangeBoundsListener)
        , 2000)
        if autoloadParties == true
          load_parties_in_zone() )
  input = document.getElementById('btnSearch')
  if input != null
    map.controls[google.maps.ControlPosition.TOP_LEFT].push(input)

window.init_map_load_parties = () ->
  init_map()
  window.autoloadParties = true
  google.maps.event.addListenerOnce(map, 'idle', () -> load_parties_in_zone() )

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
        "<div class='well row party-long'>
          <div class='party-long-ava'>
            <a href='/parties/#{party.id}'>
              <img class='party-long-img' src='#{party.get_thumb_url}'>
            </a>
          </div>
          <div class='party-long-content'>
            <a class='party-long-name h3' href='/parties/#{party.id}'>#{party.title}</a>
            <h5 class='party-long-date'>#{party.date}</h5>
            <div class='CenTex'>Tags: #{party.tag_list.join(', ')}</div>
            <a class='party-long-host h4' href='/profiles/#{party.host_id}'>
              #{party.host.profile.name}&nbsp;#{party.host.profile.surname}
            </a>
          </div>
        </div>"
      div.innerHTML += "<div name='party' data-tags='#{party.tag_list.join(', ')}' >" +
        content + "</div>"
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
    do_search()

window.init_tag_field = () ->
  params =
    'autocomplete_url': "/parties/autocomplete_tags",
    'class': 'form-control',
    'width': '100%',
    'height': '100%'
  window.tags = []
  if $('#party_tag_list').data('with-search')
    params.onAddTag = (tag) ->
      tags.push(tag)
      do_search()
    params.onRemoveTag = (tag) ->
      tags.splice(tags.indexOf(tag), 1)
      do_search()
  $('#party_tag_list').tagsInput(params)
  $('#party_tag_list_tagsinput').addClass('form-control')

window.do_search = () ->
  $("div[name='party']").each () ->
    this.hidden = false
    for tag in tags
      if this.dataset['tags'].indexOf(tag) > -1
        continue
      else
        this.hidden = true
        break

window.party_load_rating = (weight) ->
  $.ajax(url: '/parties/' + window.party_id + '/vote?weight=' + weight).done (rating) ->
    div = document.getElementById('rating')
    div.innerHTML = ''
    if rating['host_num'] == 0
      div.innerHTML += '<div class="row">Никто не оценил ни одно мероприятие, организованного этим автором.</div>'
    else
      div.innerHTML += '<div class="row">Количество голосов за пользователя в качестве организатора ' +
                       rating['host_num'] + '. Средняя оценка пользователя как организатора ' +
                       (rating['host_sum'] / rating['host_num']) + ' / 5.</div>'
    if rating['party_num'] == 0
      div.innerHTML += '<div class="row">Никто не оценил данное мероприятие.</div>'
    else
      div.innerHTML += '<div class="row">Общее количество голосов за мероприятие ' + 
                       rating['party_num'] + '. Средний рейтинг мероприятия ' +
                       rating['party_sum'] / rating['party_num'] + ' / 5.</div>'
