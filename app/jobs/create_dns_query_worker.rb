class CreateDnsQueryWorker
  include Sidekiq::Worker

  def perform(dns_query_attributes_hash)
    DnsQuery.create!(dns_query_attributes_hash)
  end
end
