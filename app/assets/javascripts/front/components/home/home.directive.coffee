angular.module 'bisyoujoZukanNight'
.directive 'homeDirective', (api, $state,$rootScope) ->
  HomeController = () ->
    vm = this
    vm.init = ->
      vm.breadcrumb = [{name:'gai dep',link:'/'}]
      vm.getFavorited()

    vm.getFavorited = ->
      api.getPromise('/api/front/api11',{}).then((res) ->
        console.log(res.data)
        vm.karaokeUsers = res.data.favorite_karaoke_users
        vm.barUsers = res.data.favorite_bar_users
        vm.massageUsers = res.data.favorite_massage_users
        vm.sexyUsers = res.data.favorite_sexy_users

        vm.newKaraokeUsers = res.data.new_karaoke_users
        vm.newBarUsers = res.data.new_bar_users
        vm.newMassageUsers = res.data.new_massage_users
        vm.newSexyUsers = res.data.new_sexy_users

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
