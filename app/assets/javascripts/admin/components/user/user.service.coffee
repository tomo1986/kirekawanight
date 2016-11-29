angular.module 'bijyoZukanAdmin'
.factory 'user', (api) ->
  sm = this
  sm.login_user = null
  sm.isLogin = -> return Boolean(sm.login_user)
  sm.setLoginUser = (user)-> sm.login_user = user
  sm.getLoginUser = -> return sm.login_user
  sm.clear = ->
    api.postPromise('/api/admin/api3',{}).then((res) ->
      sm.login_user = null
      return true
    )
  sm.newUser = ->
    api.getPromise('/api/admin/api10',{}).then((res) ->
      return res
    )

  sm.createUser = (opt_user)->
    api.postPromise('/api/admin/api11',opt_user).then((res) ->
      return res
    )
  sm.updateUser = (opt_user) ->
    api.postPromise('/api/admin/api13',opt_user).then((res) ->
      return res
    )
  sm.getUser = (opt_user_id) ->
    api.getPromise('/api/admin/api9',{id:opt_user_id}).then((res) ->
      return res
    )


  sm.getUsers = (opt_filter)->
    api.getPromise('/api/admin/api8',opt_filter).then((res) ->
      return res
    )
  sm.getSubjects = ->
    api.getPromise('/api/admin/api15',{}).then((res) ->
      return res
    )
  sm.getTags = ->
    api.getPromise('/api/admin/api44',{}).then((res) ->
      return res
    )

  sm.profile = {
    user_id:{
      is_displayed: false
      ja:{
        name: 'dep No'
        placeholder: '優しい人'
      }
      vn:{
        name: 'dep No'
        placeholder: '優しい人'
      }
      en:{
        name: 'dep No'
        placeholder: '優しい人'
      }
    }

    like_boy:{
      is_displayed: false
      ja:{
        name: '好きな男のタイプ'
        placeholder: '優しい人'
      }
      vn:{
        name: '好きな男のタイプ'
        placeholder: '優しい人'
      }
      en:{
        name: '好きな男のタイプ'
        placeholder: '優しい人'
      }
    }
    like_girl:{
      is_displayed: false
      ja:{
        name: '好きな女のタイプ'
        placeholder: '優しい人'

      }
      vn:{
        name: '好きな女のタイプ'
        placeholder: '優しい人'

      }
      en:{
        name: '好きな女のタイプ'
        placeholder: '優しい人'

      }
    }
    my_color:{
      is_displayed: false
      ja:{
        name: '自分を色で例えると？'
        placeholder: '青'

      }
      vn:{
        name: '自分を色で例えると？'
        placeholder: '青'
      }
      en:{
        name: '自分を色で例えると？'
        placeholder: '青'
      }

    }
    happy_word:{
      is_displayed: false
      ja:{
        name:'掛けられて嬉しい言葉'
        placeholder: '頑張ってるね'

      }
      vn:{
        name: '掛けられて嬉しい言葉'
        placeholder: '優しい人'

      }
      en:{
        name: '掛けられて嬉しい言葉'
        placeholder: '優しい人'
      }
    }
    love_situation: {
      is_displayed: false
      ja:{
        name: '理想の告白シチュエーション'
        placeholder: '聞き逃しそうなくらい、さらっと言われる。'

      }
      vn:{
        name: '理想の告白シチュエーション'
        placeholder: '聞き逃しそうなくらい、さらっと言われる。'

      }
      en:{
        name: '理想の告白シチュエーション'
        placeholder: '聞き逃しそうなくらい、さらっと言われる。'

      }

    }
    first_love: {
      is_displayed: false
      ja:{
        name: '初恋はいつ?'
        placeholder: '聞き逃しそうなくらい、さらっと言われる。'

      }
      vn:{
        name: '初恋はいつ?'
        placeholder: '聞き逃しそうなくらい、さらっと言われる。'

      }
      en:{
        name: '初恋はいつ?'
        placeholder: '聞き逃しそうなくらい、さらっと言われる。'

      }

    }
    how_to_approach: {
      is_displayed: true
      ja:{
        name: 'how_to_approach?'
        placeholder: '好きな人には、結構積極的になれるタイプだと思います。「会いたい！」と真っ直ぐ気持ちを伝えます。'

      }
      vn:{
        name: 'もし一目惚れしたらどうアプローチする?'
        placeholder: '好きな人には、結構積極的になれるタイプだと思います。「会いたい！」と真っ直ぐ気持ちを伝えます。'

      }
      en:{
        name: 'もし一目惚れしたらどうアプローチする?'
        placeholder: '好きな人には、結構積極的になれるタイプだと思います。「会いたい！」と真っ直ぐ気持ちを伝えます。'

      }

    }
    how_to_holiday: {
      is_displayed: true
      ja:{
        name: ' how one spends a day off'
        placeholder: 'フルートを練習したり、読書をしたり、のんびりまったり過ごす事が多いです。'

      }
      vn:{
        name: '休日の過ごし方'
        placeholder: 'フルートを練習したり、読書をしたり、のんびりまったり過ごす事が多いです。'

      }
      en:{
        name: '休日の過ごし方'
        placeholder: 'フルートを練習したり、読書をしたり、のんびりまったり過ごす事が多いです。'

      }

    }
    idea_couple: {
      is_displayed: false
      ja:{
        name: '理想のカップル'
        placeholder: '家事や子育て、仕事を、夫婦二人三脚で頑張れる相手'

      }
      vn:{
        name: '理想のカップル'
        placeholder: 'フルートを練習したり、読書をしたり、のんびりまったり過ごす事が多いです。'

      }
      en:{
        name: '理想のカップル'
        placeholder: 'フルートを練習したり、読書をしたり、のんびりまったり過ごす事が多いです。'

      }

    }
    take_one: {
      is_displayed: false
      ja:{
        name: '無人島に１つだけ持って行くもの'
        placeholder: '…家族？（笑）'

      }
      vn:{
        name: '無人島に１つだけ持って行くもの'
        placeholder: '…家族？（笑）'

      }
      en:{
        name: '無人島に１つだけ持って行くもの'
        placeholder: '…家族？（笑）'
      }
    }
    like_word: {
      is_displayed: false
      ja:{
        name: '好きな言葉'
        placeholder: '神は乗り越えられる試練しか与えない'

      }
      vn:{
        name: '好きな言葉'
        placeholder: '神は乗り越えられる試練しか与えない'

      }
      en:{
        name: '好きな言葉'
        placeholder: '神は乗り越えられる試練しか与えない'

      }

    }
    like_music: {
      is_displayed: false
      ja:{
        name: '好きな音楽'
        placeholder: 'exile'

      }
      vn:{
        name: '好きな音楽'
        placeholder: 'exile'

      }
      en:{
        name: '好きな音楽'
        placeholder: 'exile'

      }

    }
    like_movie: {
      is_displayed: true
      ja:{
        name: 'What is your favorite movie?'
        placeholder: 'タイタニック'

      }
      vn:{
        name: '好きな映画'
        placeholder: 'タイタニック'

      }
      en:{
        name: '好きな映画'
        placeholder: 'タイタニック'

      }

    }
    like_place: {
      is_displayed: false
      ja:{
        name: '好きな場所'
        placeholder: '自分の部屋'

      }
      vn:{
        name: '好きな場所'
        placeholder: '自分の部屋'

      }
      en:{
        name: '好きな場所'
        placeholder: '自分の部屋'

      }

    }
    like_sports: {
      is_displayed: false
      ja:{
        name: '好きなスポーツ'
        placeholder: 'サッカー'

      }
      vn:{
        name: '好きなスポーツ'
        placeholder: 'サッカー'

      }
      en:{
        name: '好きなスポーツ'
        placeholder: 'サッカー'

      }

    }
    like_food: {
      is_displayed: true
      ja:{
        name: 'What is your favorite food?'
        placeholder: 'カレー'

      }
      vn:{
        name: '好きな料理'
        placeholder: 'カレー'

      }
      en:{
        name: '好きな料理'
        placeholder: 'カレー'

      }

    }
    like_drink: {
      is_displayed: false
      ja:{
        name: '好きな飲み物'
        placeholder: 'コーラ'

      }
      vn:{
        name: '好きな飲み物'
        placeholder: 'コーラ'

      }
      en:{
        name: '好きな飲み物'
        placeholder: 'コーラ'

      }

    }

    best_feature:{
      is_displayed: true
      ja:{
        name: 'best feature point'
        placeholder: 'えくぼ'

      }
      vn:{
        name: 'チャームポイント'
        placeholder: 'えくぼ'

      }
      en:{
        name: 'チャームポイント'
        placeholder: 'えくぼ'

      }

    }
    love_tips: {
      is_displayed: false
      ja:{
        name: '異性を落とすコツは？'
        placeholder: 'チラチラ見る'

      }
      vn:{
        name: '異性を落とすコツは？'
        placeholder: 'チラチラ見る'

      }
      en:{
        name: '異性を落とすコツは？'
        placeholder: 'チラチラ見る'

      }

    }
    character: {
      is_displayed: true
      ja:{
        name: 'Character'
        placeholder: 'マイペース'

      }
      vn:{
        name: '性格は？'
        placeholder: 'マイペース'

      }
      en:{
        name: '性格は？'
        placeholder: 'マイペース'

      }

    }







    hobby: {
      is_displayed: true
      ja:{
        name: 'Hobby'
        placeholder: '半身浴　生花'

      }
      vn:{
        name: '趣味'
        placeholder: '半身浴　生花'

      }
      en:{
        name: '趣味'
        placeholder: '半身浴　生花'

      }

    }
    skill: {
      is_displayed: true
      ja:{
        name: 'Skill'
        placeholder: '目で殺す'

      }
      vn:{
        name: '特技は?'
        placeholder: '目で殺す'

      }
      en:{
        name: '特技は?'
        placeholder: '目で殺す'

      }

    }
    gesture: {
      is_displayed: true
      ja:{
        name: 'Heterosexuality you like'
        placeholder: '幸せそうにご飯を食べるひと'
      }
      vn:{
        name: '「ドキッ」とする異性の仕草'
        placeholder: '幸せそうにご飯を食べるひと'
      }
      en:{
        name: '「ドキッ」とする異性の仕草'
        placeholder: '幸せそうにご飯を食べるひと'
      }
    }
    attracted: {
      is_displayed: true
      ja:{
        name: 'How do you like man?'
        placeholder: '私は結構おっちょこちょいで ぬけている所が多いからか、しっかりしているお兄ちゃんみたいな人がタイプです（笑）'

      }
      vn:{
        name: 'こんな異性に惹かれます'
        placeholder: '私は結構おっちょこちょいで ぬけている所が多いからか、しっかりしているお兄ちゃんみたいな人がタイプです（笑）'

      }
      en:{
        name: 'こんな異性に惹かれます'
        placeholder: '私は結構おっちょこちょいで ぬけている所が多いからか、しっかりしているお兄ちゃんみたいな人がタイプです（笑）'

      }

    }

    habit:  {
      is_displayed: false
      ja:{
        name: '癖'
        placeholder: '爪を噛んでしまう'

      }
      vn:{
        name: '癖'
        placeholder: '爪を噛んでしまう'

      }
      en:{
        name: '癖'
        placeholder: '爪を噛んでしまう'

      }

    }
    brag:  {
      is_displayed: false
      ja:{
        name: '自慢できること'
        placeholder: 'かわいい彼女がいる'

      }
      vn:{
        name: '自慢できること'
        placeholder: 'かわいい彼女がいる'

      }
      en:{
        name: '自慢できること'
        placeholder: 'かわいい彼女がいる'

      }

    }
    my_fad: {
      is_displayed: true
      ja:{
        name: 'マイブーム'
        placeholder: 'NARUTOを見ること'
      }
      vn:{
        name: 'マイブーム'
        placeholder: 'NARUTOを見ること'

      }
      en:{
        name: 'マイブーム'
        placeholder: 'NARUTOを見ること'

      }

    }
    go: {
      is_displayed: true
      ja:{
        name: 'Now I want to go no.1'
        placeholder: '東京ディズニーランド'

      }
      vn:{
        name: '今一番行きたいところ'
        placeholder: '東京ディズニーランド'

      }
      en:{
        name: '今一番行きたいところ'
        placeholder: '東京ディズニーランド'

      }

    }
    want: {
      is_displayed: true
      ja:{
        name: 'Now I want something '
        placeholder: 'あなたの心'

      }
      vn:{
        name: '今一番欲しいもの'
        placeholder: 'あなたの心'

      }
      en:{
        name: '今一番欲しいもの'
        placeholder: 'あなたの心'

      }

    }
    do_something:  {
      is_displayed: false
      ja:{
        name: '今一番したいこと'
        placeholder: 'サッカー'

      }
      vn:{
        name: '今一番したいこと'
        placeholder: 'サッカー'

      }
      en:{
        name: '今一番したいこと'
        placeholder: 'サッカー'

      }

    }
    happy_event:  {
      is_displayed: false
      ja:{
        name: '今までで一番幸せだったこと'
        placeholder: 'わからない'

      }
      vn:{
        name: '今までで一番幸せだったこと'
        placeholder: 'わからない'

      }
      en:{
        name: '今までで一番幸せだったこと'
        placeholder: 'わからない'

      }

    }
    painful_event:  {
      is_displayed: false
      ja:{
        name: '今までで一番辛かったこと'
        placeholder: 'わからない'

      }
      vn:{
        name: '今までで一番辛かったこと'
        placeholder: 'わからない'

      }
      en:{
        name: '今までで一番辛かったこと'
        placeholder: 'わからない'

      }

    }
    previous_life: {
      is_displayed: false
      ja:{
        name: '前世は?'
        placeholder: '踊り子だと思う'

      }
      vn:{
        name: '前世は?'
        placeholder: '踊り子だと思う'

      }
      en:{
        name: '前世は?'
        placeholder: '踊り子だと思う'

      }

    }
    admire_person: {
      is_displayed: false
      ja:{
        name: '憧れる人'
        placeholder: '中田英寿'

      }
      vn:{
        name: '憧れる人'
        placeholder: '中田英寿'

      }
      en:{
        name: '憧れる人'
        placeholder: '中田英寿'

      }

    }
    dream: {
      is_displayed: true
      ja:{
        name: 'My dream'
        placeholder: 'お金持ち'

      }
      vn:{
        name: '私の夢'
        placeholder: 'お金持ち'

      }
      en:{
        name: '私の夢'
        placeholder: 'お金持ち'

      }

    }
    secret_talk: {
      is_displayed: true
      ja:{
        name: 'Secret talk'
        placeholder: '実は私パイパンです。'

      }
      vn:{
        name: 'ここだけの話'
        placeholder: '実は私パイパンです。'

      }
      en:{
        name: 'ここだけの話'
        placeholder: '実は私パイパンです。'

      }

    }
    born_again: {
      is_displayed: false
      ja:{
        name: '生まれ変わったら?'
        placeholder: '雪になりたい'

      }
      vn:{
        name: '生まれ変わったら?'
        placeholder: '雪になりたい'

      }
      en:{
        name: '生まれ変わったら?'
        placeholder: '雪になりたい'

      }

    }
    interview: {
      is_displayed: true
      ja:{
        name: 'インタビュー'
        placeholder: '雪になりたい'

      }
      vn:{
        name: 'インタビュー'
        placeholder: '雪になりたい'

      }
      en:{
        name: 'インタビュー'
        placeholder: '雪になりたい'

      }
    }

  }
  sm.getValidationRule = -> return sm.validations
  sm.validations = {
    rules:{
      name:{required: true}
      nick_name:{required: true}
      job_type:{required: true}
      birthday:{required: true}
    }
    messages:{
      name:{required: 'name is required entry'}
      name_kana:{required: 'name kana is required entry'}
      job_type:{required: 'job type is required entry'}
      birthday:{required: 'birthday is required entry'}
    }
  }
  sm.getDate = (opt_id) ->
    api.getPromise('/api/admin/api40',{id: opt_id}).then((res) ->
      return res
    )
  sm.getContacts = (opt_id) ->
    api.getPromise('/api/admin/api42',{id: opt_id}).then((res) ->
      return res
    )


  service =
    login_user: sm.login_user
    isLogin: sm.isLogin
    setLoginUser: sm.setLoginUser
    getLoginUser: sm.getLoginUser
    clear: sm.clear
    profile: sm.profile
    newUser: sm.newUser
    createUser: sm.createUser
    updateUser: sm.updateUser
    getUser: sm.getUser
    getUsers: sm.getUsers
    getSubjects: sm.getSubjects
    validations : sm.validations
    getValidationRule: sm.getValidationRule
    getDate: sm.getDate
    getContacts: sm.getContacts
    getTags: sm.getTags