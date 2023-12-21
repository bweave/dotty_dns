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

  def self.stats_for(time_frame)
    {
      queries_over_time: queries_over_time(time_frame),
      time_frame:,
      top_blocked: top_blocked(time_frame),
      top_permitted: top_permitted(time_frame),
      total_blocked: total_blocked(time_frame),
      total_domains:,
      total_permitted: total_permitted(time_frame),
      total_queries: total_queries(time_frame)
    }
  end

  def self.total_domains
    DnsRecord.distinct.count(:domain)
  end

  def self.queries_over_time(time_frame)
    format =
      case time_frame
      when 1.hour
        "hh24:mi"
      when 1.day
        "hh24:00"
      else
        "yyyy-mm-dd"
      end
    group_and_order_sql = <<~SQL.squish
          TO_CHAR(
            created_at::TIMESTAMPTZ AT TIME ZONE '#{Time.zone.now.formatted_offset}'::INTERVAL,
            'yyyy-mm-dd'
          ),
          "to_char"
        SQL
    pluck_sql = <<~SQL
        TO_CHAR(
          created_at::TIMESTAMPTZ AT TIME ZONE '#{Time.zone.now.formatted_offset}'::INTERVAL,
          '#{format}'
        ),
        COUNT(1)
      SQL

    {
      blocked:
        blocked
          .where(created_at: time_frame.ago..)
          .group(Arel.sql(group_and_order_sql))
          .order(Arel.sql(group_and_order_sql))
          .pluck(Arel.sql(pluck_sql)),
      permitted:
        ok
          .where(created_at: time_frame.ago..)
          .group(Arel.sql(group_and_order_sql))
          .order(Arel.sql(group_and_order_sql))
          .pluck(Arel.sql(pluck_sql))
    }
  end

  def self.total_queries(time_frame)
    where(created_at: time_frame.ago..).count
  end

  def self.total_blocked(time_frame)
    blocked.where(created_at: time_frame.ago..).count
  end

  def self.total_permitted(time_frame)
    ok.where(created_at: time_frame.ago..).count
  end

  def self.top_blocked(time_frame)
    blocked
      .where(created_at: time_frame.ago..)
      .group(:domain)
      .order("domain_count desc")
      .limit(10)
      .pluck("domain, COUNT(domain) AS domain_count")
  end

  def self.top_permitted(time_frame)
    ok
      .where(created_at: time_frame.ago..)
      .group(:domain)
      .order("domain_count desc")
      .limit(10)
      .pluck("domain, COUNT(domain) AS domain_count")
  end

  def self.status_for(ip_address)
    if %w[0.0.0.0 127.0.0.1].include?(ip_address)
      statuses[:blocked]
    else
      statuses[:ok]
    end
  end
end
