require "json"

class Cache

  def self.set(key, value, expire = 3600)
    make_redis

    @@redis.set(key, value.to_json)
    @@redis.expire(key, expire)
  end

  def self.get(key)
    make_redis

    JSON.parse(@@redis.get(key))
  end

  def self.make_redis
    @@redis = Redis.new if not @@redis
  end

end
