angular.module 'bijyoZukanAdmin'
.directive 'shopIndexDirective',  ->
  ShopIndexController = ($state, shopService,modalService,api) ->
    vm = this
    vm.init = ->
      vm.breadcrumb = [{name:'Dashboard',link:'/admin'},{name:'Shop List',link:''}]
      vm.filters ={limit: 20,page: if $state.params.page then $state.params.page else 1}
      vm.getShops()

      vm.googleMapFnk()

    vm.getShops = ->
      shopService.getShops(vm.filters).then((res) ->
        vm.shops = res.data.shops
        vm.total = res.data.total
        window.scrollTo(0, 0)
      )

    vm.executeDeletion = (opt_id) ->
      shopService.deleteShop({id: opt_id}).then((res) ->
        if res.data.code == 1
          modalService.alert('完了しました')
          vm.getShops()
        else
          modalService.error("error",res.data.message)
      )

    vm.onPageChanged = (page) ->
      $state.go('/shops',{page:page})
      return

    vm.googleMapFnk = ->
      map_canvas = $('#map_canvas')

      if $('#map_canvas').length
      # 鳥取駅をデフォルトの位置とする
        default_point = new google.maps.LatLng(10.780465, 106.70478600000001)
        vm.lat = 10.780465
        vm.lon = 106.70478600000001
        # マップ作成
        # map_canvasというIDがついているdivを指定
        window.big_map = new google.maps.Map(
          document.getElementById('map_canvas'),
          {
            center: default_point, #設定しないとSafariで表示されなかった
            zoom: 20,
            mapTypeId: google.maps.MapTypeId.ROADMAP,
            scaleControl: true
          }
        )

        # ユーザーの現在位置取得を試みる
        if navigator.geolocation
          navigator.geolocation.getCurrentPosition ((position) ->
            current_location = new google.maps.LatLng(position.coords.latitude, position.coords.longitude)
            opts = {zoom: 17,center: current_location, mapTypeId: google.maps.MapTypeId.ROADMAP}
            big_map = new (google.maps.Map)(document.getElementById('map_canvas'), opts)
            geocoder = new (google.maps.Geocoder)
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
            return
          ),
            'enableHighAccuracy': false
            'timeout': 8000
            'maximumAge': 2000
        else
          errorMessage = 'お使いの端末は、GeoLacation APIに対応していません。'
          alert errorMessage
      else
        alert( "あなたの端末では、現在位置を取得できません。" )

      if navigator.geolocation
        navigator.geolocation.getCurrentPosition (position) ->
          console.log(position)
          current_location = new google.maps.LatLng(position.coords.latitude, position.coords.longitude)
          opts = {zoom: 17,center: current_location, mapTypeId: google.maps.MapTypeId.ROADMAP}
          big_map = new (google.maps.Map)(document.getElementById('map_canvas'), opts)
          geocoder = new (google.maps.Geocoder)

#            big_map.setCenter(current_location)
      else
        alert 'Geocode 取得に失敗しました reason: ' + status

      existing_ids = $('#map_canvas').attr('data-shop-ids')

      google.maps.event.addListener(big_map, 'idle', ->
        pos = big_map.getBounds()
        north = pos.getNorthEast().lat()
        south = pos.getSouthWest().lat()
        east    = pos.getNorthEast().lng()
        west = pos.getSouthWest().lng()

        shop_ids = $('#map_canvas').attr('data-place-ids')
        place_ids =[]
        if (existing_ids == '' || typeof(existing_ids) == "undefined")
          shop_ids = [];
        else
          shop_ids = existing_ids.split(',')

        api.getPromise('/api/admin/api78',{north:north,south:south,east:east,west:west,shop_ids:shop_ids}).then((res) ->
          vm.mapShops = res.data.shops
          angular.forEach(vm.mapShops,(shop) ->
            markerId = "marker#{shop.id}"
            markerId = new google.maps.Marker({
              position: new google.maps.LatLng(shop.lon, shop.lat),
              draggable: false,
              map: big_map,
              animation: google.maps.Animation.DROP
            })
            if ($.inArray("#{shop.id}", place_ids) == -1)
              place_ids.push("#{shop.id}")
          )

        )
        $('#map_canvas').attr({'data-place-ids': place_ids})

      )



    vm.init()
    return
  directive =
    restrict: 'A'
    controller: ShopIndexController
    controllerAs: 'vm'
    bindToController: true
