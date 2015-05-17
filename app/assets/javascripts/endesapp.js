$(function(){
  // start setting default untuk bootstrap-notify
  $.notifyDefaults({
    allow_dismiss: true,
    animate: {
      enter: "animated fadeInRight",
      exit: "animated fadeOutRight"
    },
    newest_on_top: true,
    placement: {
      from: "top",
      align: "center"
    }
  });
  // stop setting default untuk bootstrap-notify

  // hapus margin-right yang tercreate auto setelah close modal.
  $('#modal_signin, #modal_signup').on("hidden.bs.modal", function(){
    $('#page-top').removeAttr("style");
  });

  // start clear form saat open modal
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
  // stop clear form saat open modal

  // start submit form dengan 'enter'
  $('input').keypress(function(e){
    if (e.which == 13){
      e.preventDefault();
      $('form').submit();
    }
  });
  // stop submit form dengan 'enter'

  // start custom input type=file

  $(document).on('change', '.btn-file :file', function() {
    var input = $(this),
        numFiles = input.get(0).files ? input.get(0).files.length : 1,
        label = input.val().replace(/\\/g, '/').replace(/.*\//, '');
    input.trigger('fileselect', [numFiles, label]);
    input.parents('.input-group').find(':text').val(label);
  });

  // $(document).ready( function() {
  //     $('.btn-file :file').on('fileselect', function(event, numFiles, label) {
  //         alert('opan');
  //         var input = $(this).parents('.input-group').find(':text'),
  //             log = numFiles > 1 ? numFiles + ' files selected' : label;
          
  //         if( input.length ) {
  //             input.val(log);
  //         } else {
  //             if( log ) alert(log);
  //         }
          
  //     });
  // });
  // stop custom input type=file


  // start sistem index
  $('#btn_encrypt').click(function(){
    $.get('/sistems/encrypt_form', function(data){
      $('#content').fadeOut(500, function(){
        $('#content').empty();
        $('#content').append(data.encrypt_form);
      });
      $('#content').fadeIn(500);
    });
  });

  $('#btn_decrypt').click(function(){
    $.get('/sistems/decrypt_form', function(data){
      $('#content').fadeOut(500, function(){
        $('#content').empty();
        $('#content').append(data.decrypt_form);
      });
      $('#content').fadeIn(500);
    });
  });
  // stop sistem index


});