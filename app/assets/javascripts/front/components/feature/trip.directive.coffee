angular.module 'bisyoujoZukanNight'
.directive 'featureTripDirective', (api, $state,$rootScope) ->
  HomeController = () ->
    vm = this
    vm.init = ->
      vm.breadcrumb = [{name:'キレカワ TOP',link:'/'}]
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
      slidesToShow: 2
      slidesToScroll: 2
      responsive: [
        {
          breakpoint: 1024,
          settings: {
            slidesToShow: 2,
            slidesToScroll: 2,
            infinite: true,
            dots: true
          }
        },
        {
          breakpoint: 768,
          settings: {
            slidesToShow: 1,
            slidesToScroll: 1
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
