require 'ostruct'
require 'yaml'

every 2.weeks do
  rake 'dump:create'
end

every 1.hours do
  rake 'check_tweets'
end
