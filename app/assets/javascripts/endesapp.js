$(function(){
  $('#modal_signin, #modal_signup').on("hidden.bs.modal", function(){
    $('#page-top').removeAttr("style");
  });
});