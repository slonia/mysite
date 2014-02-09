require 'ostruct'
require 'yaml'

every 2.weeks do
  rake 'dump:create'
end
