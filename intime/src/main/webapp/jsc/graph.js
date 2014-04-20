$(function() {

	var options = {
		lines : {
			show : true,
			lineWidth : 2
		},
		xaxis : {
			mode : "time"
		},
		legend : {
			position : "ne",
			backgroundOpacity : 0
		}
	};

	// fetch the data with jQuery
	function onDataReceived(series) {
		// plot all we got
		$.plot("#placeholder", series, options);

		setTimeout(function() {
			reload();
		}, seconds);
	}

	var seconds = 1000; // time in milliseconds
	var reload = function() {
		$.ajax({
			url : 'all',
			method : 'GET',
			dataType : 'json',
			success : onDataReceived,
		});
	};
	reload();

	// Add the Flot version string to the footer

	$("#footer").prepend("Flot " + $.plot.version + " &ndash; ");
});