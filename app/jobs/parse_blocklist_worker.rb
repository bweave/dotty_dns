class ParseBlocklistWorker < ApplicationJob
  def perform(
    blocklist,
    blocklist_id,
    parser = ParseBlocklist,
    create_or_update_worker = CreateOrUpdateDnsRecordWorker
  )
    Blocklist.find(blocklist_id).update!(status: :parsing)

    result = parser.call(blocklist, blocklist_id)
    fail result.error unless result.ok?

    GoodJob::Batch.enqueue(
      description: "Parsing blocklist: #{blocklist_id}",
      blocklist_id:,
      on_finish: ParsingFinishedJob
    ) do
      result
        .data
        .each_slice(10_000) do |dns_records_chunk|
          create_or_update_worker.perform_later(dns_records_chunk)
        end
    end
  end

  class ParsingFinishedJob < ApplicationJob
    def perform(batch, params)
      blocklist = Blocklist.find(batch.properties[:blocklist_id])
      status = blocklist_status_from(params[:event])
      blocklist.update!(status:)
    end

    private

    def blocklist_status_from(event)
      case event
      when :finish, :success
        :done
      when :discard
        :failed
      else
        fail "Unknown event: #{params[:event]}"
      end
    end
  end
end
