// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require bootstrap
//= require turbolinks
//= require_tree .


//Google Maps Code
var markers = [];

function initialize(action, lat, lon) {
  var mapOptions = {
    zoom: 12,
    //center: new google.maps.LatLng(-25.363882,131.044922)
  };
    map = new google.maps.Map(document.getElementById('map-canvas'),
      mapOptions);

    google.maps.event.addListener(map, 'click', function(e) {
      placeMarker(e.latLng, map);
    });

    if(action=="new")
    {
        // Try HTML5 geolocation
      if(navigator.geolocation) {
          navigator.geolocation.getCurrentPosition(function(position) {
          var pos = new google.maps.LatLng(position.coords.latitude, position.coords.longitude);
          map.setCenter(pos);

          }, 
          function() {
            handleNoGeolocation(true);
          });
        } else {
          // Browser doesn't support Geolocation
          handleNoGeolocation(false);
        }
    }
    else
    {
      if(action=="edit")
      {
        console.log("lat "+lat)
        console.log("lon "+lon)
        position = new google.maps.LatLng(lat,lon)
        var marker = new google.maps.Marker({
          position: position,
          map: map
        });
        map.panTo(position);
        markers.push(marker);
      }
    }

  
  }

  function handleNoGeolocation(errorFlag) {
    if (errorFlag) {
      var content = 'Error: The Geolocation service failed.';
    } else {
      var content = 'Error: Your browser doesn\'t support geolocation.';
    }

    var options = {
      map: map,
      position: new google.maps.LatLng(10.9638889, -74.7963889),
      content: content
    };

    var infowindow = new google.maps.InfoWindow(options);
    map.setCenter(options.position);
    }

    
  

function placeMarker(position, map) {
  deleteMarkers();
  if (position != null) 
  { 
    document.getElementById("event_latitude").value = position.lat();
    document.getElementById("event_longitude").value = position.lng();
  }
  
  var marker = new google.maps.Marker({
    position: position,
    map: map
  });
  map.panTo(position);
  markers.push(marker);
}

function setAllMap(map) {
  for (var i = 0; i < markers.length; i++) {
    markers[i].setMap(map);
  }
}

function deleteMarkers() {
  setAllMap(null)
  markers = [];
}

function test(a,b)
{
  console.log("Printing "+a+" and "+b)
}

//google.maps.event.addDomListener(window, 'load', initialize);

