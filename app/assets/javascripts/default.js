$(window).on("load", function (){
	//Load pages if you put the load tag on it
	$(".jqueryLoad").each(function (key) {
		$(this).html("Loading...");
	    var url = $(this).attr("href");
	    $(this).load(url);
	});
});