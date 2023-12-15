class CreateOrUpdateDnsRecordWorker
  include Sidekiq::Worker

  def perform(domain, ip_address, blocklist_id)
    dns_record = DnsRecord.find_or_initialize_by(domain:)
    dns_record.update!(blocklist_id:, ip_address:)
  end
end
