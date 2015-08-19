$(window).on("load", function (){
	//Load pages if you put the load tag on it
	$(".jqueryLoad").each(function (key) {
		$(this).html("Loading...");
	    var url = $(this).attr("href");
	    $(this).load(url, function(response,status){
			if ($(this).size() == 0 || status != "success") {
				$(this).html("<div class='alert alert-danger' role='alert'>Error loading page.</div>");
			}
	    });
	});
});