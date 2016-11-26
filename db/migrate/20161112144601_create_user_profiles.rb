class CreateUserProfiles < ActiveRecord::Migration[5.0]
  def change
    create_table :user_profiles do |t|
      t.references :user, index: true
      t.string :type, default:''
      t.text :my_color
      t.text :happy_word
      t.text :gesture
      t.text :attracted
      t.text :love_situation
      t.text :first_love
      t.text :how_to_approach
      t.text :how_to_holiday
      t.text :idea_couple
      t.text :take_one
      t.text :like_boy
      t.text :like_girl
      t.text :like_word
      t.text :like_music
      t.text :like_movie
      t.text :like_place
      t.text :like_food
      t.text :like_drink
      t.text :like_sports
      t.text :best_feature
      t.text :love_tips
      t.text :character
      t.text :hobby
      t.text :skill
      t.text :habit
      t.text :brag
      t.text :my_fad
      t.text :secret_talk
      t.text :born_again
      t.text :dream
      t.text :go
      t.text :want
      t.text :do_something
      t.text :happy_event
      t.text :painful_event
      t.text :previous_life
      t.text :admire_person
      t.text :interview
      t.timestamps
    end
  end
end
