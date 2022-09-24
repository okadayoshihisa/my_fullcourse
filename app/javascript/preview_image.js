$(function () {
  $('#file_btn_0').on('change', function (e) {
    var reader = new FileReader();
    reader.onload = function (e) {
      $('#preview_0').attr('src', e.target.result);
    }
    reader.readAsDataURL(e.target.files[0]);
  });
});
$(function () {
  $('#file_btn_1').on('change', function (e) {
    var reader = new FileReader();
    reader.onload = function (e) {
      $('#preview_1').attr('src', e.target.result);
    }
    reader.readAsDataURL(e.target.files[0]);
  });
});