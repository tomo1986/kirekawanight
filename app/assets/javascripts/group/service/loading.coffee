angular.module 'bijyoZukanGroup'
.directive "loadingDirective",() ->
  templateUrl: "#{location.protocol + '//' + location.host}/group/tpl/block/loading.html"
  scope:{
    size:'='
  }
  restrict: 'E'
  link: (scope, element, attrs)->
    scope.circle_size = Math.round(scope.size / 5.6)
    scope.circle_radius = scope.circle_size / 2
    scope.frotate_pattern1 = Math.floor( scope.size / 2.4 )
    scope.frotate_pattern2 = Math.floor( scope.size / 8.3 )

    scope.loading = {width:"#{scope.size}px",height:"#{scope.size}px"}
    scope.circle = {
      height:"#{scope.circle_size}px"
      width:"#{scope.circle_size}px"
      "border-radius":"#{scope.circle_radius}px"
      "-o-border-radius":"#{scope.circle_radius}px"
      "-ms-border-radius":"#{scope.circle_radius}px"
      "-webkit-border-radius":"#{scope.circle_radius}px"
      "-moz-border-radius":"#{scope.circle_radius}px"
    }
    scope.frotate1 = angular.extend({top:"#{scope.frotate_pattern1}px"}, scope.circle)
    scope.frotate2 = angular.extend({top:"#{scope.frotate_pattern2}px",left:"#{scope.frotate_pattern2}px"}, scope.circle)

    scope.frotate3 = angular.extend({left:"#{scope.frotate_pattern1}px"}, scope.circle)
    scope.frotate4 = angular.extend({top:"#{scope.frotate_pattern2}px",right:"#{scope.frotate_pattern2}px"}, scope.circle)

    scope.frotate5 = angular.extend({top:"#{scope.frotate_pattern1}px"}, scope.circle)
    scope.frotate6 = angular.extend({right:"#{scope.frotate_pattern2}px",bottom:"#{scope.frotate_pattern2}px"}, scope.circle)

    scope.frotate7 = angular.extend({left:"#{scope.frotate_pattern1}px"}, scope.circle)
    scope.frotate8 = angular.extend({left:"#{scope.frotate_pattern2}px",bottom:"#{scope.frotate_pattern2}px"}, scope.circle)
