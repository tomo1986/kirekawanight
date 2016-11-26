angular.module 'bisyoujoZukanNight'
.directive 'castDetailDirective', ($state,castService) ->
  CastDetailController = () ->
    vm = this
    vm.init = ->
      vm.breadcrumb = [{name:'TOP',link:'/'},{name:'CAST',link:'/casts'},{name:'ARISA',link:''}]
      vm.active_language = 'ja'
      vm.profile = castService.profile
      vm.contact = {
        name: null
        email: null
        tel: null
        message: '何日何時ごろ\n\n人数\n\n料金について\n\n他の女の子の名前\n\n'
      }
      vm.getCast()

    vm.getCast = ->
      castService.getCast($state.params.id).then((res) ->
        vm.cast = res.data.user
        vm.cast['profile'] = res.data.profile
        console.log(vm.cast)
        vm.castMainImg = vm.cast.images[0]
      )
    vm.onClickedImage = (opt_no) ->
      vm.castMainImg = vm.cast.images[opt_no]

    vm.casts = [
      {
        id: 1
        name: 'アリサ'
        age: 21
        rank: 'D'
        image_url: 'http://tora-shinjyuku.jp/sys_img/tora/cast/810/4/138070720169_01.jpg'
        body:{
          height: 161
          bust: 98
          bust_size: "I"
          waist: 58
          hip: 87
        }
      }
      {
        id: 2
        name: 'みかぜ'
        age: 24
        rank: 'A'
        image_url: 'http://tora-shinjyuku.jp/sys_img/tora/cast/2172/4/145353059575_5.jpg'
        body:{
          height: 167
          bust: 86
          bust_size: "E"
          waist: 57
          hip: 87
        }
      }
      {
        id: 3
        name: 'のどか'
        age: 23
        rank: 'ゴールド'
        image_url: 'http://tora-shinjyuku.jp/sys_img/tora/cast/2408/4/145870737811_shusei_1.jpg'
        body:{
          height: 156
          bust: 86
          bust_size: "D"
          waist: 56
          hip: 86
        }
      }
      {
        id: 4
        name: 'いおり'
        age: 24
        rank: 'ゴールド'
        image_url: 'http://tora-shinjyuku.jp/sys_img/tora/cast/1629/4/145473900145_shusei_1.jpg'
        body:{
          height: 156
          bust: 85
          bust_size: "F"
          waist: 55
          hip: 86
        }
      }
      {
        id: 5
        name: 'キララ'
        age: 22
        rank: 'プラチナ'
        image_url: 'http://tora-shinjyuku.jp/sys_img/tora/cast/4616/4/147485645102_shusei_1.jpg'
        body:{
          height: 160
          bust: 88
          bust_size: "F"
          waist: 57
          hip: 85
        }
      }
      {
        id: 6
        name: 'みさき'
        age: 22
        rank: 'ゴールド'
        image_url: 'http://tora-shinjyuku.jp/sys_img/tora/cast/2420/4/14766005574_shusei_1.jpg'
        body:{
          height: 155
          bust: 89
          bust_size: "G"
          waist: 56
          hip: 84
        }
      }
      {
        id: 7
        name: 'セイナ'
        age: 22
        rank: 'B'
        image_url: 'http://tora-shinjyuku.jp/sys_img/tora/cast/2983/4/147617540566_1.jpg'
        body:{
          height: 160
          bust: 85
          bust_size: "C"
          waist: 57
          hip: 82
        }
      }
      {
        id: 8
        name: 'かれん'
        age: 22
        rank: 'プラチナ'
        image_url: 'http://tora-shinjyuku.jp/sys_img/tora/cast/4184/4/147264280374_shusei_1.jpg'
        body:{
          height: 145
          bust: 83
          bust_size: "E"
          waist: 55
          hip: 84
        }
      }
      {
        id: 9
        name: 'みちる'
        age: 23
        rank: 'ファースト'
        image_url: 'http://tora-shinjyuku.jp/sys_img/tora/cast/2688/4/146727790456_shusei_3.jpg'
        body:{
          height: 164
          bust: 86
          bust_size: "D"
          waist: 58
          hip: 88
        }
      }
      {
        id: 10
        name: 'れん'
        age: 24
        rank: 'ゴールド'
        image_url: 'http://tora-shinjyuku.jp/sys_img/tora/cast/855/4/14571536199_shusei_1.jpg'
        body:{
          height: 154
          bust: 86
          bust_size: "D"
          waist: 58
          hip: 86
        }
      }
      {
        id: 11
        name: 'ひより'
        age: 25
        rank: 'A'
        image_url: 'http://tora-shinjyuku.jp/sys_img/tora/cast/1312/4/140424335682_shusei_2.jpg'
        body:{
          height: 165
          bust: 86
          bust_size: "E"
          waist: 56
          hip: 86
        }
      }
      {
        id: 12
        name: 'ゆま'
        age: 24
        rank: 'プラチナ'
        image_url: 'http://tora-shinjyuku.jp/sys_img/tora/cast/2945/4/146917540831_shusei_1.jpg'
        body:{
          height: 158
          bust: 88
          bust_size: "F"
          waist: 57
          hip: 84
        }
      }
      {
        id: 13
        name: 'メリ'
        age: 24
        rank: 'ファースト'
        image_url: 'http://tora-shinjyuku.jp/sys_img/tora/cast/78/4/14730493096_shusei_1.jpg'
        body:{
          height: 156
          bust: 82
          bust_size: "C"
          waist: 54
          hip: 80
        }
      }
      {
        id: 14
        name: 'あおい'
        age: 22
        rank: 'プラチナ'
        image_url: 'http://tora-shinjyuku.jp/sys_img/tora/cast/2154/4/144827157105_shusei_1.jpg'
        body:{
          height: 156
          bust: 82
          bust_size: "D"
          waist: 57
          hip: 82
        }
      }
      {
        id: 15
        name: 'みり'
        age: 24
        rank: 'ファースト'
        image_url: 'http://tora-shinjyuku.jp/sys_img/tora/cast/2273/4/146708940285_shusei_1.jpg'
        body:{
          height: 159
          bust: 82
          bust_size: "I"
          waist: 57
          hip: 82
        }
      }

      {
        id: 1
        name: 'アリサ'
        age: 21
        rank: 'D'
        image_url: 'http://tora-shinjyuku.jp/sys_img/tora/cast/810/4/138070720169_01.jpg'
        body:{
          height: 161
          bust: 98
          bust_size: "I"
          waist: 58
          hip: 87
        }
      }
      {
        id: 2
        name: 'みかぜ'
        age: 24
        rank: 'A'
        image_url: 'http://tora-shinjyuku.jp/sys_img/tora/cast/2172/4/145353059575_5.jpg'
        body:{
          height: 167
          bust: 86
          bust_size: "E"
          waist: 57
          hip: 87
        }
      }
      {
        id: 3
        name: 'のどか'
        age: 23
        rank: 'ゴールド'
        image_url: 'http://tora-shinjyuku.jp/sys_img/tora/cast/2408/4/145870737811_shusei_1.jpg'
        body:{
          height: 156
          bust: 86
          bust_size: "D"
          waist: 56
          hip: 86
        }
      }
      {
        id: 4
        name: 'いおり'
        age: 24
        rank: 'ゴールド'
        image_url: 'http://tora-shinjyuku.jp/sys_img/tora/cast/1629/4/145473900145_shusei_1.jpg'
        body:{
          height: 156
          bust: 85
          bust_size: "F"
          waist: 55
          hip: 86
        }
      }
      {
        id: 5
        name: 'キララ'
        age: 22
        rank: 'プラチナ'
        image_url: 'http://tora-shinjyuku.jp/sys_img/tora/cast/4616/4/147485645102_shusei_1.jpg'
        body:{
          height: 160
          bust: 88
          bust_size: "F"
          waist: 57
          hip: 85
        }
      }
      {
        id: 6
        name: 'みさき'
        age: 22
        rank: 'ゴールド'
        image_url: 'http://tora-shinjyuku.jp/sys_img/tora/cast/2420/4/14766005574_shusei_1.jpg'
        body:{
          height: 155
          bust: 89
          bust_size: "G"
          waist: 56
          hip: 84
        }
      }
      {
        id: 7
        name: 'セイナ'
        age: 22
        rank: 'B'
        image_url: 'http://tora-shinjyuku.jp/sys_img/tora/cast/2983/4/147617540566_1.jpg'
        body:{
          height: 160
          bust: 85
          bust_size: "C"
          waist: 57
          hip: 82
        }
      }
      {
        id: 8
        name: 'かれん'
        age: 22
        rank: 'プラチナ'
        image_url: 'http://tora-shinjyuku.jp/sys_img/tora/cast/4184/4/147264280374_shusei_1.jpg'
        body:{
          height: 145
          bust: 83
          bust_size: "E"
          waist: 55
          hip: 84
        }
      }
      {
        id: 9
        name: 'みちる'
        age: 23
        rank: 'ファースト'
        image_url: 'http://tora-shinjyuku.jp/sys_img/tora/cast/2688/4/146727790456_shusei_3.jpg'
        body:{
          height: 164
          bust: 86
          bust_size: "D"
          waist: 58
          hip: 88
        }
      }
      {
        id: 10
        name: 'れん'
        age: 24
        rank: 'ゴールド'
        image_url: 'http://tora-shinjyuku.jp/sys_img/tora/cast/855/4/14571536199_shusei_1.jpg'
        body:{
          height: 154
          bust: 86
          bust_size: "D"
          waist: 58
          hip: 86
        }
      }
      {
        id: 11
        name: 'ひより'
        age: 25
        rank: 'A'
        image_url: 'http://tora-shinjyuku.jp/sys_img/tora/cast/1312/4/140424335682_shusei_2.jpg'
        body:{
          height: 165
          bust: 86
          bust_size: "E"
          waist: 56
          hip: 86
        }
      }
      {
        id: 12
        name: 'ゆま'
        age: 24
        rank: 'プラチナ'
        image_url: 'http://tora-shinjyuku.jp/sys_img/tora/cast/2945/4/146917540831_shusei_1.jpg'
        body:{
          height: 158
          bust: 88
          bust_size: "F"
          waist: 57
          hip: 84
        }
      }
      {
        id: 13
        name: 'メリ'
        age: 24
        rank: 'ファースト'
        image_url: 'http://tora-shinjyuku.jp/sys_img/tora/cast/78/4/14730493096_shusei_1.jpg'
        body:{
          height: 156
          bust: 82
          bust_size: "C"
          waist: 54
          hip: 80
        }
      }
      {
        id: 14
        name: 'あおい'
        age: 22
        rank: 'プラチナ'
        image_url: 'http://tora-shinjyuku.jp/sys_img/tora/cast/2154/4/144827157105_shusei_1.jpg'
        body:{
          height: 156
          bust: 82
          bust_size: "D"
          waist: 57
          hip: 82
        }
      }
      {
        id: 15
        name: 'みり'
        age: 24
        rank: 'ファースト'
        image_url: 'http://tora-shinjyuku.jp/sys_img/tora/cast/2273/4/146708940285_shusei_1.jpg'
        body:{
          height: 159
          bust: 82
          bust_size: "I"
          waist: 57
          hip: 82
        }
      }


    ]
    vm.init()
    return
  linkFunc = (scope, el, attr, vm) ->
    return
  directive =
    restrict: 'A'
    controller: CastDetailController
    controllerAs: 'vm'
    bindToController: true
    link: linkFunc
