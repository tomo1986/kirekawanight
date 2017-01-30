angular.module 'bisyoujoZukanNight'
.directive 'homeDirective', (api, $state,$rootScope) ->
  HomeController = () ->
    vm = this
    vm.init = ->
      vm.breadcrumb = [{name:'キレカワ TOP',link:'/'}]
      vm.getFavorited()

    vm.getFavorited = ->
      api.getPromise('/api/front/api11',{}).then((res) ->
        vm.reviews = res.data.reviews
        vm.newKaraokeUsers = res.data.new_karaoke_users
        vm.newBarUsers = res.data.new_bar_users
        vm.newMassageUsers = res.data.new_massage_users
        vm.timeServices = res.data.time_services
        vm.newKaraokeShops = res.data.new_karaoke_shops
        vm.newBarShops = res.data.new_bar_shops
        vm.newMassageShops = res.data.new_massage_shops
      )


    vm.init()
    return
  linkFunc = (scope, el, attr, vm) ->
    $('.slick-slider').slick
      dots: true
      accessibility: true
      infinite: true
      centerMode: true
      autoplay: true,
      autoplaySpeed: 4000
      slidesToShow: 3
      slidesToScroll: 1
      responsive: [
        {
          breakpoint: 1024,
          settings: {
            slidesToShow: 3,
            slidesToScroll: 1,
            infinite: true,
            dots: true
          }
        },
        {
          breakpoint: 768,
          settings: {
            slidesToShow: 2,
            slidesToScroll: 2
          }
        },
        {
          breakpoint: 568,
          settings: {
            slidesToShow: 1,
            slidesToScroll: 1
          }
        }
    ]

    return
  directive =
    restrict: 'A'
    controller: HomeController
    controllerAs: 'vm'
    bindToController: true
    link: linkFunc
