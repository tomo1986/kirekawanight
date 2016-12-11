angular.module 'bisyoujoZukanNight'
.directive 'datePickerDirective', ($state,$rootScope) ->
  DatePickerController = ($scope) ->
    vm = this
    self = vm
    vm.inputName
    vm.options
    vm.date

    vm.picker =
      date: new Date()
      datepickerOptions: {showWeeks: false}
      timepickerOptions: if vm.options.timepickerOptions then vm.options.timepickerOptions else {}

    vm.picker.datepickerOptions["maxDate"] = vm.options.from.date if vm.options && vm.options.from && vm.options.from.is_from
    vm.picker.datepickerOptions["minDate"] = vm.options.to.date if vm.options && vm.options.to && vm.options.to.is_to
#    vm.picker["timepickerOptions"]["max"] = vm.options.from.date if vm.options && vm.options.from && vm.options.from.is_from
#    vm.picker["timepickerOptions"]["min"] = vm.options.to.date if vm.options && vm.options.to && vm.options.to.is_to


    vm.openCalendar = (e, picker) ->
      self[picker].open = true

    return
  linkFunc = (scope, el, attr, vm) ->
    scope.vm.ngModel = vm
    scope.$watch("vm.data",(val) ->
      if val
        scope.vm.data[scope.vm.inputName] = if val[scope.vm.inputName] then new Date(val[scope.vm.inputName]) else null
    )

    scope.$watch("vm.options.to.date",(val) ->
      scope.vm.picker.datepickerOptions["minDate"] = val
    )
    scope.$watch("vm.options.from.date",(val) ->
      scope.vm.picker.datepickerOptions["maxDate"] = val
    )
    return

  directive =
    replace: true
    require: '?ngModel'
    transclude:true
    controller: DatePickerController
    controllerAs: 'vm'
    templateUrl: "#{location.protocol + '//' + location.host}/front/tpl/block/datepicker.html"
    scope:{
      inputName:'@'
      options: '='
      data: "="
    }
    bindToController: true
    link: linkFunc
