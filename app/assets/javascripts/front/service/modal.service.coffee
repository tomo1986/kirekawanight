angular.module 'bisyoujoZukanNight'
.factory 'modalService', ($uibModal,$state,api) ->
  sm = this
  sm.error = (message) ->
    modalInstance = $uibModal.open(
      templateUrl: "#{location.protocol + '//' + location.host}/front/tpl/modal/error.html"
      windowClass: 'my-block-bottom'
      keyboard: false
      backdropClick: false
      backdrop: 'static'
      controller: ($scope)->
        self = $scope
        self.message = message
        self.close = ()->
          modalInstance.dismiss('cancel')
          $state.go('/')
    )
  sm.alert = (title,message) ->
    modalInstance = $uibModal.open(
      templateUrl: "#{location.protocol + '//' + location.host}/front/tpl/modal/error.html"
      windowClass: 'my-block-bottom'
      controller: ($scope)->
        self = $scope
        self.title = title
        self.message = message
        self.close = ()->
          modalInstance.dismiss('cancel')
    )

  sm.delete = (message,callback) ->
    modalInstance = $uibModal.open(
      templateUrl: "#{location.protocol + '//' + location.host}/front/tpl/modal/delete.html"
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
  sm.confirm = (title,datas,buttons) ->
    modalInstance = $uibModal.open(
      templateUrl: "#{location.protocol + '//' + location.host}/front/tpl/modal/confirm.html"
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

        self.close = ()->
          $state.go('/')
          modalInstance.dismiss('cancel')

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
  sm.createCustomer = (callback) ->
    modalInstance = $uibModal.open(
      templateUrl: "#{location.protocol + '//' + location.host}/front/tpl/modal/create_customer.html"
      windowClass: 'my-block-bottom'
      keyboard: false
      backdropClick: false
      backdrop: 'static'
      controller: ($scope)->
        self = $scope
        self.isLoginFormDisplayed = false
        self.isCreateFormDisplayed = false
        self.callbackFunc = callback
        self.customer = {
          name: null
          email: null
          password: null
        }

        self.close = ()->
          modalInstance.dismiss('cancel')

        self.onLogined = () ->
          self.isLoginFormDisplayed = true

        self.onCreated = () ->
          self.isCreateFormDisplayed = true

        self.onSubmited = ()->
          if self.isLoginFormDisplayed
            api.postPromise('/api/front/api10',self.customer).then((res) ->
              self.callbackFunc(res.data.customer)
              modalInstance.dismiss('cancel')
            )
          else if self.isCreateFormDisplayed
            api.postPromise('/api/front/api9',self.customer).then((res) ->
              self.callbackFunc(res.data.customer)
              modalInstance.dismiss('cancel')
            )

    )
  service =
    error:sm.error
    alert: sm.alert
    confirm: sm.confirm
    getAddress: sm.getAddress
    delete: sm.delete
    createCustomer: sm.createCustomer
