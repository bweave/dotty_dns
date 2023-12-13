class DnsRecord < ApplicationRecord
  validates :domain, presence: true, uniqueness: true
  validates :ip_address, presence: true, ip_address: true

  # TODO: add an enabled boolean and only do these if enabled?
  after_commit :update_dns_cache, on: %i[create update]
  after_commit :remove_from_dns_cache, on: :destroy

  private

  def update_dns_cache
    Redis.dns_cache.write domain, ip_address
  end

  def remove_from_dns_cache
    Redis.dns_cache.delete domain
  end
end
