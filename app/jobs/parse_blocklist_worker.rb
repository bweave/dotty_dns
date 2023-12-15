class ParseBlocklistWorker
  include Sidekiq::Worker

  def perform(
    blocklist,
    blocklist_id,
    parser = ParseBlocklist,
    create_or_update_worker = CreateOrUpdateDnsRecordWorker
  )
    result = parser.call(blocklist)
    if result.ok?
      result.data.each do |dns_record_data|
        create_or_update_worker.perform_async(*dns_record_data, blocklist_id)
      end
    else
      fail result.error
    end
  end
end
