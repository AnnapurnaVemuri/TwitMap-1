<html>
	<head>
		<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>
		<script src="https://maps.googleapis.com/maps/api/js?v=3.exp&libraries=visualization"></script>
	</head>
	<body>
    	<script>
     		function setupEventSource() {
        		var output = document.getElementById("output");
        		if (typeof(EventSource) !== "undefined") {
          			var elt = document.getElementById("keyWordSelect");
          			var msg = elt.options[elt.selectedIndex].text;
          			var source = new EventSource("twitmapsse?msg=" + msg);
          			source.onmessage = function(event) {
  						var myLatlng = new google.maps.LatLng(-25.363882,131.044922);
 	        			var locations = event.data;
    	        		var location = locations.split(" ");
    					latlongList = [];
    					
    					var mapOptions = {
    	    				zoom: 2,
   							center:myLatlng,
   							mapTypeId: google.maps.MapTypeId.SATELLITE
    	    			}
    					var mapOptions2 = {
    	    			    zoom: 2,
   							center:myLatlng,
   							mapTypeId: google.maps.MapTypeId.TERRAIN		
    	    			}
    					var map = new google.maps.Map(document.getElementById('map'), mapOptions);
    					var map2 = new google.maps.Map(document.getElementById('map2'), mapOptions);
    		
    					location.forEach(function(l) {
    						if (l == undefined || l.length == 0) {
    							return;
    						}
    						var latLong = l.split(",");
    						if (latLong.length != 2) {
    							return;
    						}
    						var latlng = new google.maps.LatLng(latLong[0],latLong[1] );
    						latlongList.push(latlng);
    			 			new google.maps.Marker({
    							position : latlng,
    							map : map2
    						}); 
    			 		});
    				
    					var pointArray = new google.maps.MVCArray(latlongList);
						var heatmap = new google.maps.visualization.HeatmapLayer({
  				    		data: pointArray
  				  		});
  				  		heatmap.setMap(map);
		  			}
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
    	<div id="map" style="width: 1000px; height: 500px; "></div>
    	<div id="map2" style="width: 1000px; height: 500px;"></div> 
    </div>
    
  </body>
</html>