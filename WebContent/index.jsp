<html>
<head><script src="http://ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script><script src="https://maps.googleapis.com/maps/api/js?v=3.exp&libraries=visualization"></script></head>
  <body>
    <script>
    var map, pointarry, heatmap, latlongList;
	/*var shouldExit = false;
    var geoCodeRequestCompleteFlag = 0;
    	function getLocationLatLong(location) {
    		var locationlength = location.length;
    		var latlongList = [];
        	var geocoder = new google.maps.Geocoder();
        	var gotResponse = 0;
			location.forEach(function(address) {
				$.getJSON(
						'http://maps.googleapis.com/maps/api/geocode/json?address='
								+ address + '&sensor=false', null, function(
								data) {
							if (data.results[0] != undefined) {
								var p = data.results[0].geometry.location;
								var latlng = new google.maps.LatLng(p.lat, p.lng);
								latlongList.push(latlng);
							}

						});
				geocoder.geocode({
		        	   'address': address
		        	}, function(results, status) {
		        		gotResponse++;
		        	   if(status == google.maps.GeocoderStatus.OK) {
		        		   var p = results[0].geometry.location;
							var latlng = new google.maps.LatLng(p.lat(), p.lng());
							latlongList.push(latlng);
							geoCodeRequestCompleteFlag++;
		        	        //if (latlongList.length == locationlength) {
		        	        	//geoCodeRequestCompleteFlag = 1;
		        	        //}
		        	   }
		        	});
			});
			setTimeout(function() {alert(shouldExit);document.shouldExit = true;}, 10000);
			while( gotResponse != locationlength && document.shouldExit == false ) {
			    // wait
			}
			return latlongList;
    	}*/
      function setupEventSource() {
        var output = document.getElementById("output");
        /*var locations = "Hyderabad||GET BAD||Bangalore||New York||Philadelphia||Connecticut||Shangai||BREAKING BAD||London||Hyderabad||Stamford||Manhattan||San Diego"
        	var location = locations.split("||");
        geoCodeRequestCompleteFlag = 0;
        document.shouldExit = false;
			var latlongList = getLocationLatLong(location);


			  //var pointArray = new google.maps.MVCArray(latlongList);

			var mapOptions = {
				    zoom: 8,
				    mapTypeId: google.maps.MapTypeId.SATELLITE
				  };

				var  map = new google.maps.Map(document.getElementById('map'),
				      mapOptions);


				  var heatmap = new google.maps.visualization.HeatmapLayer({
				    data: latlongList
				  });

				  heatmap.setMap(map);*/
				  
        if (typeof(EventSource) !== "undefined") {
          var elt = document.getElementById("keyWordSelect");
          var msg = elt.options[elt.selectedIndex].text;
          console.log(msg);
          var source = new EventSource("twitmapsse?msg=" + msg);
          source.onmessage = function(event) {
        	var locations = event.data;
        	//locations = "Hyderabad||GET BAD||Bangalore||New York||Philadelphia||Connecticut||Shangai||BREAKING BAD||London||Hyderabad||Stamford||Manhattan||San Diego"
        	var location = locations.split("||");
			latlongList = [];
			location.forEach(function(l) {
				if (l == undefined || l.length == 0) {
					return;
				}
				var latLong = l.split(",");
				if (latLong.length != 2) {
					return;
				}
				var latlng = new google.maps.LatLng(latLong[0], latLong[1]);
				latlongList.push(latlng);
			});
			var mapOptions = {
				    zoom: 8,
				    mapTypeId: google.maps.MapTypeId.SATELLITE
				  };

			map = new google.maps.Map(document.getElementById('map'),
				      mapOptions);
        	/*var geocoder = new google.maps.Geocoder();
        	
			location.forEach(function(address) {
				geocoder.geocode({
		        	   'address': address
		        	}, function(results, status) {
		        	   if(status == google.maps.GeocoderStatus.OK) {
		        		   var p = results[0].geometry.location;
							var latlng = new google.maps.LatLng(p.lat, p.lng);
							latlongList.push(latlng);
		        	         new google.maps.Marker({
		        	            position: results[0].geometry.location,
		        	            map: map
		        	         });
		        	         map.setCenter(results[0].geometry.location);
		        	   }
		        	});
			});*/


				  pointArray = new google.maps.MVCArray(latlongList);

				  heatmap = new google.maps.visualization.HeatmapLayer({
				    data: pointArray
				  });

				  heatmap.setMap(map);
          };
        } else {
          output.innerHTML = "Sorry, Server-Sent Event is not supported in your browser";
        }
        return false;
      }
    </script>

    <h2>Tweet Map Demo</h2>
    <div>
    	<select id="keyWordSelect">
		  <option value="all">All</option>
		  <option value="bad">Bad</option>
		  <option value="ball">Ball</option>
		  <option value="great">Great</option>
		  <option value="world">World</option>
		  <option value="tv">TV</option>
		  <option value="show">Show</option>
		  <option value="sun">Sun</option>
		  <option value="love">Love</option>
		  <option value="fun">Fun</option>
		</select>
      <input type="button" id="sendID" value="Get Locations" onclick="setupEventSource()"/>
    </div>
    <hr/>
    <div id="output">
    	<div id="map" style="width: 1000px; height: 500px;"></div> 
    </div>
  </body>
</html>