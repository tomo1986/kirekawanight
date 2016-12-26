angular.module 'bisyoujoZukanNight'
  .run (api, customerService) ->
    'ngInject'
    api.connect().then((res) ->
      if res.code == 1
        customerService.setLoginCustomer(res.customer)
    )
