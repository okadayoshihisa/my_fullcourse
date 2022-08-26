function initMap(){
  geocoder = new google.maps.Geocoder()
  map = []
  marker = []
  infoWindow = []

  window.onload = ()=> {
    let path = location.pathname
    //マップページ
    if (path == '/fullcourse_menus/map') {
      map = new google.maps.Map(document.getElementById("map"), {
          zoom: 10,
          center: {lat: 35.676192, lng: 139.650311},
      });
      for (let i = 0; i < gon.menus.length; i++) {
        //メニュー名、緯度経度がある時だけピン立て
        if (gon.menus[i].name && gon.lat[i] && gon.lng[i]) {
          marker[i] = new google.maps.Marker({
              position: {lat: gon.lat[i], lng: gon.lng[i]},
              map: map,
          });
          if (gon.menus[i].menu_image.url == 'sample.jpg') {
            infoWindow[i] = new google.maps.InfoWindow({
              content: `${gon.menus[i].name}`,
            });
          } else {
            infoWindow[i] = new google.maps.InfoWindow({
              content: `<img src=${gon.menus[i].menu_image.url} width="150" heght="50" /><br><p>${menus[i].name}</p>`,
            });
          }
          markerEvent(i);
        }
      }
    } else {     
      for (let i = 0; i < 8; i++) {
        //フルコースメニュー新規作成時
        if (path == '/fullcourse_menus/new') {
          map[i] = new google.maps.Map(document.getElementById(`map${i}`), {
            center: {lat: 35.676192, lng: 139.650311},
            zoom: 12 
          });
        //フルコースメニュー更新、更新失敗時
        } else if (path == '/fullcourse_menus' || path.includes(`/fullcourse_menus/${gon.user.id}`)) {
          if (gon.lat[i] && gon.lng[i]) {
            map[i] = new google.maps.Map(document.getElementById(`map${i}`), {
              center: {lat: gon.lat[i], lng: gon.lng[i]},
              zoom: 12 
            });
            marker[i] = new google.maps.Marker({
              map: map[i],
              position: {lat: gon.lat[i], lng: gon.lng[i]}
            });
          } else {
            map[i] = new google.maps.Map(document.getElementById(`map${i}`), {
              center: {lat: 35.676192, lng: 139.650311},
              zoom: 12 
            });
          }
        }
        map[i].addListener('click', function(e) {
          getClickLatLng(e.latLng, i);
        });
      }
    }   
  }
}
window.initMap = initMap;

let activeWindow
//マップページ マーカークリックイベント
function markerEvent(i) {
  marker[i].addListener('click', function() {
    if (activeWindow !== undefined) {
      activeWindow.close();
    }
    infoWindow[i].open(map, marker[i]);
    activeWindow = infoWindow[i];
  });  
}

function getClickLatLng(lat_lng, i) {
  if (marker[i]) {
  marker[i].setMap(null);
  }
  marker[i] = new google.maps.Marker({
    position: lat_lng,
    map: map[i]
  });
  map[i].panTo(lat_lng);
  //マップのクリックした地点の住所、緯度経度をフォームに入れる
  geocoder.geocode( { latLng: lat_lng}, function(results, status) {
    if (status == 'OK') {
      address = document.getElementById(`address_${i}`);
      address.value = results[0].formatted_address;
      latitude = document.getElementById(`latitude_${i}`);
      latitude.value = results[0].geometry.location.lat();
      longitude = document.getElementById(`longitude_${i}`);
      longitude.value = results[0].geometry.location.lng();
    }
  });
}

// //住所を入力すると緯度経度を取得しフォームに入れる
// function getLatLng(i){
//   address = document.getElementById(`address_${i}`);
//   latitude = document.getElementById(`latitude_${i}`);
//   longitude = document.getElementById(`longitude_${i}`);
//   geocoder.geocode( { 'address': address.value }, function(results, status) {
//     if (status == 'OK') {
//       map[i].setCenter(results[0].geometry.location);
//       if (marker[i]) {
//         marker[i].setMap(null);
//       }
//       marker[i] = new google.maps.Marker({
//         map: map[i],
//         position: results[0].geometry.location
//       });
//       latitude.value = results[0].geometry.location.lat();
//       longitude.value = results[0].geometry.location.lng();
//     }else if (!address.value){
//       if (marker[i]) {
//         marker[i].setMap(null);
//       }
//       latitude.value = null;
//       longitude.value = null;
//     }else {
//       alert('該当する結果がありませんでした：' + status); 
//     }
//   });
// }

// //店名入力で住所と緯度経度を取得し、フォームに入力
// function codeAddress(i){
//   inputName = document.getElementById(`name_${i}`).value;
//   address = document.getElementById(`address_${i}`);
//   latitude = document.getElementById(`latitude_${i}`);
//   longitude = document.getElementById(`longitude_${i}`);
//   geocoder.geocode( { 'address': inputName}, function(results, status) {
//     if (status == 'OK') {
//       map[i].setCenter(results[0].geometry.location);
//       if (marker[i]) {
//         marker[i].setMap(null);
//       }
//       marker[i] = new google.maps.Marker({
//         map: map[i],
//         position: results[0].geometry.location
//       });
//       address.value = results[0].formatted_address;
//       latitude.value = results[0].geometry.location.lat();
//       longitude.value = results[0].geometry.location.lng();
//     } else if (!inputName) {
//       if (marker[i]) {
//         marker[i].setMap(null);
//       }
//       address.value = null;
//       latitude.value = null;
//       longitude.value = null;
//     }else {
//       alert('該当する結果がありませんでした：' + status);
//     }
//   });
// }
