angular.module 'bijyoZukanAdmin'
  .config ($logProvider, toastrConfig, $httpProvider,uiDatetimePickerConfig,paginationTemplateProvider,lazyImgConfigProvider) ->
    'ngInject'
    # Enable log
    $logProvider.debugEnabled true
    # Set options third-party lib
    toastrConfig.allowHtml = true
    toastrConfig.timeOut = 3000
    toastrConfig.positionClass = 'toast-top-right'
    toastrConfig.preventDuplicates = true
    toastrConfig.progressBar = true
    $httpProvider.defaults.withCredentials = true
    $httpProvider.defaults.withCredentials = true
    $httpProvider.defaults.cache = false
    delete $httpProvider.defaults.headers.common["X-Requested-With"]
    $httpProvider.defaults.headers.post['Content-Type'] = 'application/x-www-form-urlencoded;application/json;charset=utf-8'
    uiDatetimePickerConfig.showWeeks = false
    uiDatetimePickerConfig.dayTitleFormat = "yyyy年 MMMM"
    uiDatetimePickerConfig.buttonBar.today.text = "本日"
    uiDatetimePickerConfig.buttonBar.clear.text = "消去"
    uiDatetimePickerConfig.buttonBar.time.text = "時間"
    uiDatetimePickerConfig.buttonBar.date.text = "日付"
    uiDatetimePickerConfig.buttonBar.close.text = "閉じる"
    uiDatetimePickerConfig.showMeridian = false
    scrollable = document.querySelector('#scrollable')
    lazyImgConfigProvider.setOptions
      offset: 100
      errorClass: 'error'
      successClass: 'success'
      onError: (image) ->
      onSuccess: (image) ->
      container: angular.element(scrollable)
    return

