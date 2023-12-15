require "test_helper"

class FetchBlocklistWorkerTest < ActiveSupport::TestCase
  include MockTestHelp

  def setup
    @blocklist = blocklists(:one)
    @list = <<~LIST
      0.0.0.0 ads.com
      0.0.0.0 more-ads.com
    LIST
  end

  test "it fetches the remote blocklist and enqueues parsing" do
    fetcher = Minitest::Mock.new
    fetcher.expect(:call, Result.new(@list), [@blocklist.url])

    parser_worker = Minitest::Mock.new
    parser_worker.expect(:perform_async, :ret_val, [@list, @blocklist.id])

    described_class.new.perform(@blocklist.id, fetcher, parser_worker)

    fetcher.verify
    parser_worker.verify
  end

  test "it fails loudly if the blocklist can't be fetched" do
    failing_fetcher = Minitest::Mock.new
    failing_fetcher.expect(
      :call,
      Result.new(nil, StandardError.new("fetching failed")),
      [@blocklist.url]
    )

    assert_raises "StandardError" do
      described_class.new.perform(@blocklist.id, failing_fetcher)
    end

    failing_fetcher.verify
  end
end
