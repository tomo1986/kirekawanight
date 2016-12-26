angular.module 'bisyoujoZukanNight'
  .controller 'IndexController', (customerService,api,$scope) ->
    $scope.init = ->
      console.log("soeya")
      $scope.isActive = false
      $scope.isParentActive = false
      $scope.isParentChild = false
      $scope.loginCustomer = customerService.getLoginCustomer()
      api.getPromise('/api/front/api20',{}).then((res) ->
        $scope.userCount = res.data.user_count
        $scope.shopCount = res.data.shop_count
      )

    $scope.onClickedLogout = ->
      customerService.clear().then((res)->
        window.location.reload()
      )

    $scope.eventOpenParent =  ->
      $scope.isParentActive = !$scope.isParentActive
      $scope.isParentChild = false if !$scope.isParentActive

    $scope.eventOpenchild = ->
      $scope.isParentChild = !$scope.isParentChild

    $scope.eventCalled = ->
      $scope.isActive = !$scope.isActive
      console.log($scope.isActive)

    $scope.onClosed = ->
      $scope.isActive = !$scope.isActive
    $scope.init()


