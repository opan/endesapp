$(function(){
  // hapus margin-right yang tercreate auto setelah close modal.
  $('#modal_signin, #modal_signup').on("hidden.bs.modal", function(){
    $('#page-top').removeAttr("style");
  });

  // clear form saat open modal
  $('[data-dismiss=modal]').on('click', function (e) {
    var $t = $(this),
        target = $t[0].href || $t.data("target") || $t.parents('.modal') || [];

    $(target)
      .find("input[name!='authenticity_token'][name!='utf8'],textarea,select")
         .val('')
         .end()
      .find("input[type=checkbox], input[type=radio]")
         .prop("checked", "")
         .end();
  });

});