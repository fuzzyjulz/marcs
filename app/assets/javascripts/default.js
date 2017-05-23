function reloadJavascripts(){
	//Load pages if you put the load tag on it
	$(".jqueryLoad").each(function (key) {
  var url = $(this).attr("href");
  $(this).removeClass("jqueryLoad");
  loaderDiv = $(this);
  loaderDiv.html("<div class='badge'>Loading</div>");
  $(this).load(url, function(response,status){
   if ($(this).size() === 0 || status !== "success") {
   	loaderDiv.html("<div class='alert alert-danger' role='alert'>Error loading page.</div>");
   } else {
    $(document).load();
   }
  });
	});

 $(".openNewWindow").each(function (key) {
  $(this).css("cursor","hand");
  $(this).click(function () {
   window.open($(this).attr("href"), '_blank');
  });
 });

 $("[data-toggle=tooltip]").tooltip();
 
 //Collapse for radio buttons based on a target
 $("input[data-toggle='radio-collapse']").each(function () {
  var key = this;
  var group = $("input[name='"+key.name+"']");
  group.change(function(){
   $($(key).attr("data-target")).collapse(this == key && key.checked ? "show":"hide");
  });
  $($(key).attr("data-target")).addClass(key.checked ? "in":"collapse");
 });

 $("input[data-toggle='enable']").each(function () {
  var target = $($(this).attr("data-target"));
  
  $(this).change(function(){
   target.prop("disabled",!this.checked);
  });
  if (!this.enabled)
   target.prop("disabled",!this.checked);
 });
 
 function clearErrors(){
  $(this).parent().removeClass("field_with_errors").find("span").remove();
 }
 $(".field_with_errors input").change(clearErrors);
 $(".field_with_errors input").keydown(clearErrors);
};

$(document).load(reloadJavascripts);
$(document).ready(reloadJavascripts);
$(document).on('turbolinks:load', reloadJavascripts);
