angular.module 'bijyoZukanGroup'
.directive "imageCropper",($uibModal, $timeout,$state,$rootScope,Cropper) ->
  scope:{
    options:'='
  }
  require: "?ngModel"
  restrict: 'AE'
  link: (scope, element, attrs,ngModel)->
    file = null
    image_data = null
    scope.cropper = {}
    data = {}
    options = scope.options || {}
    options.aspectRatio = options.aspectRatio || 1
    options.crop = (dataNew)->
      data = dataNew
    angular.element(element).on 'change',(event)->
      Cropper.encode((file = event.currentTarget.files[0])).then((dataUrl)->
        exif_data = 1
        image_data = new Image()
        image_data.src = dataUrl
        image_data.onload = () ->
          EXIF.getData(image_data, () ->
            exif_data = EXIF.getTag(this, 'Orientation')
          )
          if(typeof(exif_data) != 'undefined')
            options.orientation = exif_data

          modalInstance = $uibModal.open(
            templateUrl: "#{location.protocol + '//' + location.host}/group/tpl/modal/image_crop.html"
            windowClass: 'my-block-bottom'
            keyboard: false
            backdropClick: false
            backdrop: 'static'
            controller: ($scope)->
              self = $scope
              self.myImage = image_data.src
              self.cropper = {}
              data = {}
              self.options = options
              self.showEvent = 'show';
              self.hideEvent = 'hide';
              self.cropperProxy = 'cropper.first'

              $timeout(()->
                $scope.$broadcast($scope.showEvent)
              )

              self.close = ()->
                $(event.currentTarget).val('')
                modalInstance.dismiss('cancel')

              self.commit = ->
                Cropper.crop(file, data).then(Cropper.encode).then((dataUrl)->
                  ngModel.$setViewValue(dataUrl)
                  ngModel.$render()
                  $(event.currentTarget).val('')
                  modalInstance.dismiss('cancel')
                )
          )
      )




