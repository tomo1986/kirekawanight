angular.module 'bijyoZukanAdmin'
.factory 'modalService', ($uibModal,$state) ->
  sm = this
  sm.error = (message) ->
    modalInstance = $uibModal.open(
      templateUrl: "#{location.protocol + '//' + location.host}/admin/tpl/modal/error.html"
      windowClass: 'my-block-bottom'
      controller: ($scope)->
        self = $scope
        self.message = message
        self.close = ()->
          modalInstance.dismiss('cancel')
    )
  sm.alert = (message) ->
    modalInstance = $uibModal.open(
      templateUrl: "#{location.protocol + '//' + location.host}/admin/tpl/modal/error.html"
      windowClass: 'my-block-bottom'
      controller: ($scope)->
        self = $scope
        self.message = message
        self.close = ()->
          modalInstance.dismiss('cancel')
    )

  sm.selectedCell = (count,capsule_count,callback) ->
    modalInstance = $uibModal.open(
      templateUrl: "#{location.protocol + '//' + location.host}/admin/tpl/modal/select_cell.html"
      animation: true
      controller: ($scope)->
        self = $scope
        self.selected_cell = if count then count else null
        self.callbackFunc = callback
        self.has_capsule = capsule_count

        self.mouseOverCounter = (cell_no) ->
          self.selected_cell = cell_no

        self.decideCellCount = (cell_no) ->
          return if self.has_capsule > cell_no
          self.callbackFunc(cell_no)
          modalInstance.dismiss('cancel')

        self.close = ()->
          modalInstance.dismiss('cancel')
    )
  sm.delete = (message,callback) ->
    modalInstance = $uibModal.open(
      templateUrl: "#{location.protocol + '//' + location.host}/admin/tpl/modal/delete.html"
      animation: true
      controller: ($scope)->
        self = $scope
        self.callbackFunc = callback
        self.message = message
        self.executeDeletion = () ->
          self.callbackFunc()
          modalInstance.dismiss('cancel')
        self.close = ()->
          modalInstance.dismiss('cancel')
    )


  sm.imageModal = (img) ->
    modalInstance = $uibModal.open(
      templateUrl: "#{location.protocol + '//' + location.host}/front/tpl/directive/image_modal.html"
      windowClass: 'my-block-bottom'
      controller: ($scope)->
        self = $scope
        self.myImage = img
        self.close = ()->
          modalInstance.dismiss('cancel')
    )
  sm.confirm = (title,datas,buttons) ->
    modalInstance = $uibModal.open(
      templateUrl: "#{location.protocol + '//' + location.host}/admin/tpl/modal/confirm.html"
      windowClass: 'my-block-bottom'
      keyboard: false
      backdropClick: false
      backdrop: 'static'
      controller: ($scope)->
        self = $scope
        self.title = title
        self.datas = datas
        self.buttons = buttons
        self.callbackFunc = undefined

        self.onChangePage = ()->
          modalInstance.dismiss('cancel')

        self.onCallback = (callback) ->
          self.callbackFunc = callback
          self.callbackFunc()
          modalInstance.dismiss('cancel')
    )
  sm.normalIcons = (callback) ->
    modalInstance = $uibModal.open(
      templateUrl: "#{location.protocol + '//' + location.host}/admin/tpl/modal/icon_list.html"
      windowClass: 'my-block-bottom'
      keyboard: false
      backdropClick: false
      backdrop: 'static'
      controller: ($scope,capsuleService)->
        self = $scope
        self.callbackFunc = callback
        self.init = ->
          self.getIconStyles()
          self.icons = null
          self.styles = null
          self.icon = null
          self.icon_id = null

        self.selectedIcon = (icon) ->
          self.icon = icon
          self.icon_id = icon.id

        self.close = ()->
          modalInstance.dismiss('cancel')

        self.getIconStyles = ->
          capsuleService.getIconStyles().then((res) ->
            if res.code == 1
              self.styles = res.data
          )

        self.getStyleIcons = () ->
          capsuleService.getStyleIcons(self.style_id).then((res) ->
            if res.code == 1
              self.icons = res.data.get_icons
          )

        self.changeIcon = (style_id) ->
          self.style_id = style_id
          self.icon = null
          self.getStyleIcons()

        self.decideIcon = () ->
          self.callbackFunc(self.icon)
          modalInstance.dismiss('cancel')

        self.onChangePage = (state)->
          modalInstance.dismiss('cancel')

        self.carouselInitializer = ->
          $(document).ready(() ->
            $('.owl-carousel').owlCarousel(
              itemsCustom : [
                [0, 3]
                [450, 3]
                [600, 4]
                [700, 4]
                [1000, 4]
                [1200, 4]
                [1400, 4]
                [1600, 4]
              ]
              navigation: true
              pagination: false
              autoPlay: false
              navigationText: [
                '<img src=\'/assets/admin/slider/slide-pre.png\'>'
                '<img src=\'/assets/admin/slider/slide-next.png\'>'
              ]
            )
          )

        self.init()
    )
  sm.getAddress = (position, callback) ->
    modalInstance = $uibModal.open(
      templateUrl: "#{location.protocol + '//' + location.host}/business/tpl/modal/map.html"
      windowClass: 'my-block-bottom'
      keyboard: false
      backdropClick: false
      backdrop: 'static'
      controller: ($scope)->
        $(document).ready ->
          self = $scope
          self.callbackFunc = callback
          self.search_address = null
          self.address = if position.address then position.address else null
          self.ido = position.location[1]
          self.keido = position.location[0]
          self.Marker = undefined
          self.map = undefined
          self.geocoder = new (google.maps.Geocoder)

          self.getAddress = () ->
            self.codeAddress(self.search_address)

          self.close = ()->
            modalInstance.dismiss('cancel')
            self.geocoder = null

          self.getLocation = () ->
            self.callbackFunc(self.ido,self.keido,self.address)
            modalInstance.dismiss('cancel')

          self.settings = ->

            latlng = new (google.maps.LatLng)(self.ido, self.keido)
            self.opts = {zoom: 17,center: latlng, mapTypeId: google.maps.MapTypeId.ROADMAP}
            self.map = new (google.maps.Map)(document.getElementById('map_canvas'), self.opts)
            self.geocoder = new (google.maps.Geocoder)
            $('#loading-box').empty()
            self.mapClickFunc()

          self.geocode = ->
            self.geocoder.geocode { 'location': self.Marker.getPosition() }, (results, status) ->
              if status == google.maps.GeocoderStatus.OK and results[0]
                $scope.$apply(() -> $scope.address = results[0].formatted_address)
              else
                $scope.$apply(() -> $scope.address = 'Geocode 取得に失敗しました')
                alert 'Geocode 取得に失敗しました reason: ' + status
              return
            return

          self.infotable = (ido, keido, level) ->
            self.ido = ido
            self.keido = keido
            $scope.level = level
            return

          self.mapClickFunc = () ->
            google.maps.event.addListener self.map, 'click', (event) ->
              if self.Marker
                self.Marker.setMap null
              self.Marker = new (google.maps.Marker)(
                position: event.latLng
                draggable: true
                map: self.map)
              self.infotable self.Marker.getPosition().lat(), self.Marker.getPosition().lng(), self.map.getZoom()
              self.geocode()
              google.maps.event.addListener self.Marker, 'dragend', (event) ->
                self.infotable self.Marker.getPosition().lat(), self.Marker.getPosition().lng(), self.map.getZoom()
                self.geocode()
                return
              google.maps.event.addListener self.map, 'zoom_changed', (event) ->
                self.infotable self.Marker.getPosition().lat(), self.Marker.getPosition().lng(), self.map.getZoom()
                return
              return
            return

          self.codeAddress = (address) ->
            self.Marker = undefined
            self.map = new (google.maps.Map)(document.getElementById('map_canvas'), self.opts)
            self.mapClickFunc()
            self.initAddress(address)

          self.initAddress = (address) ->
            self.geocoder.geocode { 'address': address }, (results, status) ->
              if status == google.maps.GeocoderStatus.OK
                self.map.setCenter results[0].geometry.location
                self.Marker = new (google.maps.Marker)(
                  map: self.map
                  position: results[0].geometry.location
                )
                self.ido = self.Marker.getPosition().lat()
                self.keido = self.Marker.getPosition().lng()
                $scope.level = self.map.getZoom()
                $scope.$apply(() -> self.address = results[0].formatted_address)
              else
                console.log 'Geocode was not successful for the following reason: ' + status
                document.getElementById('id_address').innerHTML = 'Geocode 取得に失敗しました'
                alert 'Geocode 取得に失敗しました reason: ' + status

          self.init = () ->
            if self.ido && self.keido
              self.settings()
              self.initAddress(self.address)
            if !self.ido && !self.keido
              if navigator.geolocation
                navigator.geolocation.getCurrentPosition ((position) ->
                    data = position.coords
                    self.ido = data.latitude
                    self.keido = data.longitude
                    self.settings()
                  ), ((error) ->
                    self.ido = 35.689488
                    self.keido = 139.691706
                    self.settings()
                    return
                  ),
                  'enableHighAccuracy': false
                  'timeout': 8000
                  'maximumAge': 2000
              else
                self.ido = 35.689488
                self.keido = 139.691706
                self.settings()
    )

  service =
    error:sm.error
    alert: sm.alert
    selectedCell: sm.selectedCell
    imageModal: sm.imageModal
    confirm: sm.confirm
    normalIcons: sm.normalIcons
    getAddress: sm.getAddress
    delete: sm.delete
