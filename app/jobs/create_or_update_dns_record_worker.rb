class CreateOrUpdateDnsRecordWorker < ApplicationJob
  def perform(dns_records_chunk)
    DnsRecord.upsert_all(
      dns_records_chunk,
      unique_by: :index_dns_records_on_domain,
      on_duplicate: Arel.sql("ip_address = EXCLUDED.ip_address")
    )
  end
end
