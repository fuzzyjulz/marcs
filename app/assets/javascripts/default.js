function jqueryload_ready(){
	//Load pages if you put the load tag on it
	$(".jqueryLoad").each(function (key) {
  var url = $(this).attr("href");
  loaderDiv = $(this);
  loaderDiv.html("<div class='badge'>Loading</div>");
  $(this).load(url, function(response,status){
   if ($(this).size() == 0 || status != "success") {
   	loaderDiv.html("<div class='alert alert-danger' role='alert'>Error loading page.</div>");
   }
  });
	});
	
	$("[data-toggle=tooltip]").tooltip();
};
