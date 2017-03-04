angular.module 'bisyoujoZukanNight'
.directive 'mapIndexDirective', (api, $state,$rootScope) ->
  MapIndexController = () ->
    vm = this
    vm.init = ->
      vm.breadcrumb = [{name:'キレカワ TOP',link:'/'},{name:'MAPから検索',link:''}]
      map_canvas = $('#map_canvas')
      vm.loading = true
      if $('#map_canvas').length
        if navigator.geolocation
          navigator.geolocation.getCurrentPosition ((position) ->
              current_location = new google.maps.LatLng(position.coords.latitude, position.coords.longitude)
              window.big_map = new google.maps.Map(
                document.getElementById('map_canvas'),
                {
                  center: current_location,
                  zoom: 20,
                  mapTypeId: google.maps.MapTypeId.ROADMAP,
                  scaleControl: true
                }
              )
              big_map.setCenter(current_location)
              vm.selectLocation()
            ), ((error) ->
              errorInfo = [
                '原因不明のエラーが発生しました…。'
                '位置情報の取得が許可されませんでした…。'
                '電波状況などで位置情報が取得できませんでした…。'
                '位置情報の取得に時間がかかり過ぎてタイムアウトしました…。'
              ]
              errorNo = error.code
              errorMessage = '[エラー番号: ' + errorNo + ']\n' + errorInfo[errorNo]
              alert errorMessage
              default_point = new google.maps.LatLng(10.780465, 106.70478600000001)
              window.big_map = new google.maps.Map(
                document.getElementById('map_canvas'),
                {
                  center: default_point, #設定しないとSafariで表示されなかった
                  zoom: 20,
                  mapTypeId: google.maps.MapTypeId.ROADMAP,
                  scaleControl: true
                }
              )
              vm.selectLocation()
              return
            ),
            'enableHighAccuracy': false
            'timeout': 8000
            'maximumAge': 2000
        else
          errorMessage = 'お使いの端末は、GeoLacation APIに対応していません。'
          alert errorMessage
          default_point = new google.maps.LatLng(10.780465, 106.70478600000001)
          window.big_map = new google.maps.Map(
            document.getElementById('map_canvas'),
            {
              center: default_point, #設定しないとSafariで表示されなかった
              zoom: 20,
              mapTypeId: google.maps.MapTypeId.ROADMAP,
              scaleControl: true
            }
          )
          vm.selectLocation()

      else
        alert( "お客様の端末では、現在位置を取得できません。" )
        default_point = new google.maps.LatLng(10.780465, 106.70478600000001)
        window.big_map = new google.maps.Map(
          document.getElementById('map_canvas'),
          {
            center: default_point, #設定しないとSafariで表示されなかった
            zoom: 20,
            mapTypeId: google.maps.MapTypeId.ROADMAP,
            scaleControl: true
          }
        )
        vm.selectLocation()

      vm.selectLocation = ->
        google.maps.event.addListener(big_map, 'idle', ->
          vm.loading = true
          pos = big_map.getBounds()
          north = pos.getNorthEast().lat()
          south = pos.getSouthWest().lat()
          east    = pos.getNorthEast().lng()
          west = pos.getSouthWest().lng()

          api.getPromise('/api/admin/api78',{north:north,south:south,east:east,west:west}).then((res) ->
            vm.shops = res.data.shops
            vm.loading = false
            angular.forEach(vm.shops,(shop) ->

              markerId = "marker#{shop.id}"
              infoWindowId = "infoWindow#{shop.id}"
              markerId = new google.maps.Marker({
                position: new google.maps.LatLng(shop.lon, shop.lat),
                draggable: false,
                map: big_map,
                animation: google.maps.Animation.DROP
              })
              shop_image =  '<img src="#{shop.images[0].url}">' if shop.images[0] && shop.images[0].url
              infoWindowId = new (google.maps.InfoWindow)(
                content: "<div class='sample' style='width:200px;'>
                            <p class='' style='float:left;width:30px;'></p>
                            <div class='' style='float:right:width:100px;'>
                              <p> <a href='http://night.kire-kawa.com/shops/"+shop.job_type+"/"+shop.id+"/info' target='_blank'>#{shop.name}</a></p>

                            </div>

                          </div>"
              )
              markerId.addListener 'click', ->
                infoWindowId.open big_map, markerId
                return
            )
          )
        )



    vm.init()
    return
  linkFunc = (scope, el, attr, vm) ->
    return
  directive =
    restrict: 'A'
    controller: MapIndexController
    controllerAs: 'vm'
    bindToController: true
    link: linkFunc
