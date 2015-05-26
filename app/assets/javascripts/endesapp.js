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

  // start home
  $('#btn_modal_sign_up').click(function(){
    $.get('/home/modal_signup',function(data){
      $('#html_modal_signup').append(data.signup);
      $('#modal_signup').modal('show');
    });
  });

  $('#btn_modal_sign_in').click(function(){
    $.get('/home/modal_signin', function(data){
      $('#html_modal_signin').append(data.signin);
      $('#modal_signin').modal('show');
    });
  });

  // stop home

  // hapus margin-right yang tercreate auto setelah close modal.

  $('#modal_signin, #modal_signup').on("hidden.bs.modal", function(){
    $('#page-top').removeAttr("style");
    $('#html_modal_signin, #html_modal_signup').empty();
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
    $.loader.open({
      title: 'Tunggu sebentar...'
    });

    $.ajax({
      xhr: function(){
        var xhr = new window.XMLHttpRequest();

        xhr.addEventListener("progress", function(evt){
          if (evt.lengthComputable) {
            var percentComplete = evt.loaded / evt.total;
            //Do something with download progress
            // console.log(percentComplete * 100);
            // console.log(evt.loaded);
            // console.log(evt.total);
          }
        }, false);
        return xhr;
      },
      type: 'get',
      url: '/sistems/encrypt_form',
      dataType: 'json',
      success: function(data){
        $('#content').fadeOut(500, function(){
          $('#content').empty();
          $('#content').append(data.encrypt_form);
        });
        $('#content').fadeIn(500);
        $.loader.close();
      }
    });
    // $.get('/sistems/encrypt_form', function(data){
    //   $('#content').fadeOut(500, function(){
    //     $('#content').empty();
    //     $('#content').append(data.encrypt_form);
    //   });
    //   $('#content').fadeIn(500);
    // });
  });

  $('#btn_decrypt').click(function(){
    $.loader.open({
      title: 'Tunggu sebentar...'
    });

    $.get('/sistems/decrypt_form', function(data){
      $('#content').fadeOut(500, function(){
        $('#content').empty();
        $('#content').append(data.decrypt_form);
      });
      $('#content').fadeIn(500);
      $.loader.close();
    });
  });
  // stop sistem index

  // start extend method jquery validate
  jQuery.validator.addMethod("filesize", function(value, element, params) {
    file_size   = showInMB(element.files[0].size, true);
    return this.optional(element) || file_size <= params[0]
  }, jQuery.validator.format("File size cannot greater than {0} {1}"));
  // stop extend method jquery validate

  function showInMB(bytes, si){
    calculate = Math.abs(bytes) / 1000 / 1000;
    return calculate.toFixed(1);
  }

  function humanFileSize(bytes, si) {
    var thresh = si ? 1000 : 1024;
    if(Math.abs(bytes) < thresh) {
        // return bytes + ' B';
        // bypass jika dibawah 1 MB, selalu true;
        return 0;
    }
    var units = si
        ? ['kB','MB','GB','TB','PB','EB','ZB','YB']
        : ['KiB','MiB','GiB','TiB','PiB','EiB','ZiB','YiB'];
    var u = -1;
    do {
        bytes /= thresh;
        ++u;
    } while(Math.abs(bytes) >= thresh && u < units.length - 1);
    // return bytes.toFixed(1)+' '+units[u];
    // uncomment jika memerlukan unit satuan.
    return bytes.toFixed(1);
  }

});