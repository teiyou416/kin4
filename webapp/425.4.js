function creatMap(result,status){
	if(status===google.maps.GeocoderStatus.OK){
		//console.log(result);
		var myOptions={
			zoom:14,
			center:myPosition,
			mapTypeId:google.maps.MapTypeId.ROADMAP
		};
		var myMap=new google.maps.Map(document.getElementById("map_canvas"),myOptions);
		}
	}
		function drawMap(myAddress){
			var geocoder=new goo
		}