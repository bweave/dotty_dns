class FetchBlocklistWorker
  include Sidekiq::Worker

  def perform(
    id,
    fetcher = FetchBlocklist,
    parser_worker = ParseBlocklistWorker
  )
    url = Blocklist.where(id:).pick(:url)
    result = fetcher.call(url)
    if result.ok?
      parser_worker.perform_async(result.data, id)
    else
      fail result.error
    end
  end
end
