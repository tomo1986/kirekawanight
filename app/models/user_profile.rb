class UserProfile < ApplicationRecord
  belongs_to :user

  def to_jbuilder
    Jbuilder.new do |json|
      json.user_id self.user_id
      json.my_color self.my_color
      json.character self.character
      json.best_feature self.best_feature
      json.hobby self.hobby
      json.dream self.dream
      json.like_boy self.like_boy
      json.like_food self.like_food
      json.like_drink self.like_drink
      json.skill self.skill
      json.love_situation self.love_situation
      json.how_to_holiday self.how_to_holiday
      json.like_music self.like_music
      json.like_place self.like_place
      json.go self.go
      json.want self.want
      json.secret_talk self.secret_talk

      json.happy_word self.happy_word
      json.first_love self.first_love
      json.idea_couple self.idea_couple
      json.take_one self.take_one
      json.like_girl self.like_girl
      json.like_word self.like_word
      json.like_sports self.like_sports
      json.love_tips self.love_tips
      json.gesture self.gesture
      json.attracted self.attracted
      json.how_to_approach self.how_to_approach
      json.habit self.habit
      json.brag self.brag
      json.my_fad self.my_fad
      json.born_again self.born_again
      json.do_something self.do_something
      json.happy_event self.happy_event
      json.painful_event self.painful_event
      json.previous_life self.previous_life
      json.admire_person self.admire_person
      json.interview self.interview
    end
  end


  def self.select_like_movie
    movies = [
        'タイタニック','ステイ・フレンズ','忘れられない人','きみに読む物語','親愛なるきみへ','セイフ ヘイヴン','ジュリエットからの手紙',
        'ハイスクール・ミュージカル','セブンティーン・アゲイン','きみがくれた未来','TIME','かぞくはじめました','抱きたい関係','キス&キル',
        '男と女の不都合な真実','愛とセックスとセレブリティ','プリティプリンセス','プリティプリンセス2','プラダを着た悪魔','ワン・デイ23年のラブストーリー','P.S. アイラブユー',
        'ツーリスト','ウェディングプランナー','ニューヨークの恋人','ビフォア・サンライズ恋人までの距離','ビフォア・サンセット','ビフォア・ミッドナイト','ゴースト',
        '50回目のファーストキス','25年目のキス','ノッティングヒルの恋人','星に想いを','めぐり逢えたら','ユー・ガット・メール','トゥー・ウィークス・ノーティス',
        '天空の城ラピュタ','となりのトトロ','火垂るの墓','魔女の宅急便','おもひでぽろぽろ','紅の豚','平成狸合戦ぽんぽこ',
        '耳をすませば','もののけ姫','千と千尋の神隠し','猫の恩返し','ハウルの動く城','崖の上のポニョ','借りぐらしのアリエッティ'
    ]
    return movies[rand(movies.length)]
  end

  def self.select_day_off
    day_offs = [
        '女友達とショッピングしています。',
        '女友達とカフェにいきます。',
        'ずっと家でゴロゴロしています。',
        '家でテレビを見ています。',
        'のんびり過ごしています'
    ]
    return day_offs[rand(day_offs.length)]
  end


end
