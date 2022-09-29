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

function imgDelete(){
  var file = document.getElementById(`file_btn_${this.i}`);
  file.value = null;
}
window.addEventListener('DOMContentLoaded', function() {
  console.log('hoge');
  let deleteBtn = [];
  for (let i = 0; i < 8; i++) {
    deleteBtn[i] = document.getElementById(`delete_btn_${i}`);
    deleteBtn[i].addEventListener("click", {i: i, handleEvent: imgDelete});
  }
});
