require "redis"

REDIS = Redis.new(:host => ENV["redis_host"], :port => ENV["redis_port"])