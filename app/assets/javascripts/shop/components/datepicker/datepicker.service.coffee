angular.module 'bijyoZukanShop'
.factory 'datePickerService', () ->
  sm = this
  sm.callBackUtcDate = (date) ->
    return '' if date == null || date == '' || date == undefined

    after_date = if sm.confIs('Date', date) then date else new Date(date)
    localTime = after_date.getTime()
    localOffset = after_date.getTimezoneOffset() * 60000
    utc = localTime + localOffset
    return new Date(utc)

  sm.confIs = (type,obj) ->
    clas = Object.prototype.toString.call(obj).slice(8, -1)
    return obj != undefined && obj != null && clas == type

  service =
    callBackUtcDate: sm.callBackUtcDate
    confIs: sm.confIs