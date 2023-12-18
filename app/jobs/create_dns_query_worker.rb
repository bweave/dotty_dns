class CreateDnsQueryWorker < ApplicationJob
  def perform(dns_query_attributes_hash)
    # TODO: coming soon
    DnsQuery.create!(dns_query_attributes_hash)
  end
end
