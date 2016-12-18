# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# bundle exec whenever --update-crontab
# bundle exec whenever --clear-crontab
set :output, "log/cron.log"

every :day, :at => '0:00 am' do
  runner "Shop.avg_shop_score"
end
every :day, :at => '0:15 am' do
  runner "Shop.score_ranking"
end


every :day, :at => '1:00 am' do
  runner "User.avg_user_score"
end
every :day, :at => '1:15 am' do
  runner "User.score_ranking"
end

every :day, :at => '1:00 pm' do
  runner "Shop.make_daily_authentication_code"
end

