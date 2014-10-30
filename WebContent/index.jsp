<html>
<head><script src="https://maps.googleapis.com/maps/api/js?v=3.exp&libraries=visualization"></script></head>
  <body>
    <script>
	var shouldExit = false;
    var geoCodeRequestCompleteFlag = 0;
    	function getLocationLatLong(location) {
    		var locationlength = location.length;
    		var latlongList = [];
        	var geocoder = new google.maps.Geocoder();
        	
			location.forEach(function(address) {
				geocoder.geocode({
		        	   'address': address
		        	}, function(results, status) {
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
			setTimeout(function(){document.shouldExit = true}, 30000);
			while( latlongList.length != locationlength && document.shouldExit == false ) {
			    // wait
			  }
			return latlongList;
    	}
      function setupEventSource() {
        var output = document.getElementById("output");
        var locations = "Hyderabad||GET BAD||Bangalore||New York||Philadelphia||Connecticut||Shangai||BREAKING BAD||London||Hyderabad||Stamford||Manhattan||San Diego"
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

				  heatmap.setMap(map);
				  
        if (typeof(EventSource) !== "undefined") {
          var msg = document.getElementById("textID").value;
          var source = new EventSource("twitmapsse?msg=" + msg);
          source.onmessage = function(event) {
        	//var locations = event.data;
        	locations = "Hyderabad||GET BAD||Bangalore||New York||Philadelphia||Connecticut||Shangai||BREAKING BAD||London||Hyderabad||Stamford||Manhattan||San Diego"
        	var location = locations.split("||");
			var latlongList = [];
			var mapOptions = {
				    zoom: 8,
				    mapTypeId: google.maps.MapTypeId.SATELLITE
				  };

				var  map = new google.maps.Map(document.getElementById('map'),
				      mapOptions);
        	var geocoder = new google.maps.Geocoder();
        	
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
			});


				  var pointArray = new google.maps.MVCArray(latlongList);

				  var heatmap = new google.maps.visualization.HeatmapLayer({
				    data: pointArray
				  });

				  heatmap.setMap(map);
        	
            //output.innerHTML += event.data + "<br>";
          };
        } else {
          output.innerHTML = "Sorry, Server-Sent Event is not supported in your browser";
        }
        return false;
      }
    </script>

    <h2>Simple SSE Echo Demo</h2>
    <div>
      <input type="text" id="textID" name="message" value="Hello World">
      <input type="button" id="sendID" value="Send" onclick="setupEventSource()"/>
    </div>
    <hr/>
    <div id="output">
    	<div id="map" style="width: 1000px; height: 500px;"></div> 
    </div>
  </body>
</html>