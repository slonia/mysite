require 'ostruct'
require 'yaml'

every 2.weeks do
  rake 'dump:create'
end

every 12.hours do
  rake 'check_tweets'
end
