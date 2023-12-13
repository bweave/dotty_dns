Redis.cattr_accessor :dns_cache

# TODO: configure the Redis url per environment
Redis.dns_cache =
  ActiveSupport::Cache::RedisCacheStore.new(db: 1, url: "redis://127.0.0.1")
