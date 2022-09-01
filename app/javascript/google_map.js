function initMap(){
  geocoder = new google.maps.Geocoder()
  maps = []
  markers = []
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
        //メニュー名、緯度経度がある時だけマーカー設置
        if (gon.menus[i].name && gon.lat[i] && gon.lng[i]) {
          markers[i] = new google.maps.Marker({
              //同じ座標でも＋(Math.random() / 25000)で若干ずらして表示
              position: {lat: gon.lat[i], lng: gon.lng[i] + (Math.random() / 10000)},
              map: map,
          });
          //画像が登録されていない時ウィンドウにはメニュー名のみ表示
          if (gon.menus[i].menu_image.url == 'sample.jpg') {
            infoWindow[i] = new google.maps.InfoWindow({
              content: `<a href='/fullcourse_menus/${gon.menus[i].id}', class='link'>
                        ${gon.menus[i].name}<br>
                        ${gon.menus[i].store.name}</a>`,
            });
          } else {
            infoWindow[i] = new google.maps.InfoWindow({
              content: `<a href='/fullcourse_menus/${gon.menus[i].id}', class='link'>
                        <img src=${gon.menus[i].menu_image.url} width="150" heght="50" /><br>
                        ${gon.menus[i].name}<br>
                        ${gon.menus[i].store.name}</a>`,
            });
          }
          //マーカークリックイベント
          markerEvent(i);
          infoWindow[i].open(map, markers[i]);
        }
      }
      //フルコースメニュー新規作成時
    } else if (path == '/fullcourse_menus/new') {
      for (let i = 0; i < 8; i++) {
        maps[i] = new google.maps.Map(document.getElementById(`map${i}`), {
          center: {lat: 35.676192, lng: 139.650311},
          zoom: 12 
        });
        maps[i].addListener('click', function(e) {
          getClickLatLng(e.latLng, i);
        });
      }
      //フルコースメニュー編集ページ、更新失敗時      
    } else if (path == '/fullcourse_menus' || path.includes(`/fullcourse_menus/${gon.user_id}`)) {
      for (let i = 0; i < 8; i++) {
        if (gon.lat[i] && gon.lng[i]) {
          maps[i] = new google.maps.Map(document.getElementById(`map${i}`), {
            center: {lat: gon.lat[i], lng: gon.lng[i]},
            zoom: 12
          });
          markers[i] = new google.maps.Marker({
            map: maps[i],
            position: {lat: gon.lat[i], lng: gon.lng[i]}
          });
        } else {
          maps[i] = new google.maps.Map(document.getElementById(`map${i}`), {
            center: {lat: 35.676192, lng: 139.650311},
            zoom: 12
          });
        }
        maps[i].addListener('click', function(e) {
          getClickLatLng(e.latLng, i);
        });
      }
      //メニュー詳細ページ
    } else {
      map = new google.maps.Map(document.getElementById('show_map'), {
        center: gon.latlng,
        zoom: 12
      });
      marker = new google.maps.Marker({
        map: map,
        position: gon.latlng
      });
    }
  }
}
window.initMap = initMap;

let frontWindow
let frontMaker
//マップページ マーカークリックイベント
function markerEvent(i) {
  markers[i].addListener('click', function() {
    //ウィンドウを前面に表示
    if (frontWindow !== undefined) {
      frontWindow.setZIndex(0);
    }
    infoWindow[i].setZIndex(90);
    frontWindow = infoWindow[i];
    //マーカーを前面に表示
    if (frontMaker !== undefined) {
      frontMaker.setZIndex(0);
    }
    markers[i].setZIndex(90);
    frontMaker = markers[i];
  });  
}

function getClickLatLng(lat_lng, i) {
  if (markers[i]) {
  markers[i].setMap(null);
  }
  markers[i] = new google.maps.Marker({
    position: lat_lng,
    map: maps[i]
  });
  maps[i].panTo(lat_lng);
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
