class DnsQuery < ApplicationRecord
  enum :status, { blocked: 0, ok: 1 }
  enum :dns_type,
       {
         A: 0,
         AAAA: 1,
         SRV: 2,
         SOA: 3,
         PTR: 4,
         TXT: 5,
         NS: 6,
         SVCB: 7,
         HTTPS: 8
       }
  enum :reply_type, { IP: 0, CNAME: 1, NXDOMAIN: 2, NODATA: 3 }

  validates :domain, presence: true, url: true
  validates :requested_by, presence: true
  validates :dns_type, presence: true
  validates :status, presence: true
  validates :reply_from, presence: true
  validates :reply_type, presence: true
  validates :reply_time_ms, presence: true, numericality: { greater_than: 0 }

  def self.status_for(ip_address)
    if %w[0.0.0.0 127.0.0.1].include?(ip_address)
      statuses[:blocked]
    else
      statuses[:ok]
    end
  end
end
