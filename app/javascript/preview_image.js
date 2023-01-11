for (let i = 0; i < 8; i++) {
  $(function () {
    $(`#file_btn_${i}`).on('change', function (e) {
      var reader = new FileReader();
      reader.onload = function (e) {
        $(`#preview_${i}`).attr('src', e.target.result);
      }
      reader.readAsDataURL(e.target.files[0]);
    });
  });
  $(function () {
    $(`#file_btn_${i}`).on('change', function (e) {
      var reader = new FileReader();
      reader.onload = function (e) {
        $(`#preview_${i}`).attr('src', e.target.result);
      }
      reader.readAsDataURL(e.target.files[0]);
    });
  });
}

function imgDelete(){
  var file = document.getElementById(`file_btn_${this.i}`);
  file.value = null;
}
window.addEventListener('DOMContentLoaded', function() {
  let deleteBtn = [];
  for (let i = 0; i < 8; i++) {
    deleteBtn[i] = document.getElementById(`delete_btn_${i}`);
    deleteBtn[i].addEventListener("click", {i: i, handleEvent: imgDelete});
  }
});
