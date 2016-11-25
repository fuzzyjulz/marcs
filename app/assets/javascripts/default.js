function jqueryload_ready(){
	//Load pages if you put the load tag on it
	$(".jqueryLoad").each(function (key) {
  var url = $(this).attr("href");
  $(this).removeClass("jqueryLoad");
  loaderDiv = $(this);
  loaderDiv.html("<div class='badge'>Loading</div>");
  $(this).load(url, function(response,status){
   if ($(this).size() == 0 || status != "success") {
   	loaderDiv.html("<div class='alert alert-danger' role='alert'>Error loading page.</div>");
   }
  });
	});

 $(".openNewWindow").each(function (key) {
  $(this).click(function () {
   window.open($(this).attr("href"), '_blank');
  });
 });

	$("[data-toggle=tooltip]").tooltip();
};
