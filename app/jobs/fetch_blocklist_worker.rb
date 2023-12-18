class FetchBlocklistWorker < ApplicationJob
  def perform(
    id,
    fetcher = FetchBlocklist,
    parser_worker = ParseBlocklistWorker
  )
    blocklist = Blocklist.find(id)
    blocklist.update!(status: :fetching)
    result = fetcher.call(blocklist.url)
    if result.ok?
      parser_worker.perform_later(result.data, id)
    else
      fail result.error
    end
  end
end
