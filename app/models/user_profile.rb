class UserProfile < ApplicationRecord
  belongs_to :user

  def to_jbuilder
    Jbuilder.new do |json|
      json.user_id self.user_id
      json.my_color self.my_color
      json.happy_word self.happy_word
      json.love_situation self.love_situation
      json.first_love self.first_love
      json.how_to_holiday self.how_to_holiday
      json.idea_couple self.idea_couple
      json.take_one self.take_one
      json.like_boy self.like_boy
      json.like_girl self.like_girl
      json.like_word self.like_word
      json.like_music self.like_music
      json.like_movie self.like_movie
      json.like_place self.like_place
      json.like_food self.like_food
      json.like_drink self.like_drink
      json.like_sports self.like_sports
      json.best_feature self.best_feature
      json.love_tips self.love_tips
      json.character self.character
      json.hobby self.hobby
      json.skill self.skill
      json.gesture self.gesture
      json.attracted self.attracted
      json.how_to_approach self.how_to_approach

      json.habit self.habit
      json.brag self.brag
      json.my_fad self.my_fad
      json.secret_talk self.secret_talk
      json.born_again self.born_again
      json.dream self.dream
      json.go self.go
      json.want self.want
      json.do_something self.do_something
      json.happy_event self.happy_event
      json.painful_event self.painful_event
      json.previous_life self.previous_life
      json.admire_person self.admire_person
      json.interview self.interview
    end
  end





end
