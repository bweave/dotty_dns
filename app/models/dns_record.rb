class DnsRecord < ApplicationRecord
  validates :domain, presence: true, uniqueness: true
  validates :ip_address, presence: true, ip_address: true
end
