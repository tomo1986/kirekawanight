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

  sm.modalSelectCasts = (casts,selectCasts,callback) ->
    modalInstance = $uibModal.open(
      templateUrl: "#{location.protocol + '//' + location.host}/front/tpl/modal/cast.html"
      animation: true
      controller: ($scope)->
        self = $scope
        self.callbackFunc = callback
        self.casts = casts
        self.count = 0
        self.selectCasts = selectCasts

        self.onClickselectCasts = () ->
          self.callbackFunc(self.selectCasts)
          modalInstance.dismiss('cancel')
        self.onselectCast = (cast) ->
          if self.selectCasts["cast#{cast.id}"]
            delete self.selectCasts["cast#{cast.id}"]
          else
            self.selectCasts["cast#{cast.id}"] = cast
          self.count = Object.keys(self.selectCasts).length

        self.close = ()->
          self.selectCasts = {}
          self.callbackFunc(self.selectCasts)
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

        self.onChangePage = ()->
          modalInstance.dismiss('cancel')

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
            api.postPromise('/api/front/api0',self.customer).then((res) ->
              if res.data.code == 1
                self.callbackFunc(res.data.customer)
                modalInstance.dismiss('cancel')
              else
                self.error = "メールアドレスとパスワードが一致しません。"
            )
          else if self.isCreateFormDisplayed
            api.postPromise('/api/front/api9',self.customer).then((res) ->
              if res.data.code == 1
                self.callbackFunc(res.data.customer)
                modalInstance.dismiss('cancel')
              else
                self.error = "すでに登録されているアドレスです。"
            )

    )
  service =
    error:sm.error
    alert: sm.alert
    confirm: sm.confirm
    delete: sm.delete
    modalSelectCasts: sm.modalSelectCasts
    createCustomer: sm.createCustomer
