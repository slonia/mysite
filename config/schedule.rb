require 'ostruct'
require 'yaml'

every 2.weeks do
  rake 'dump:create'
end

every 15.minutes do
  rake 'check_tweets'
end
