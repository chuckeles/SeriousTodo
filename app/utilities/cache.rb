class Cache

  @@redis = nil

  def self.set(key, value, expire = 3600)
    make_redis

    @@redis.set(key, value)
    @@redis.expire(key, expire)
  end

  def self.get(key)
    make_redis

    @@redis.get(key)
  end

  def self.make_redis
    @@redis = Redis.new if not @@redis
  end

end
