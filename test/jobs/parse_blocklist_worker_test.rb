require "test_helper"

class ParseBlocklistWorkerTest < ActiveSupport::TestCase
  include MockTestHelp

  def setup
    @blocklist ||= blocklists(:one)
    @list = <<~LIST
      0.0.0.0 ads.com
      0.0.0.0 more-ads.com
    LIST
  end

  test "it parses the blocklist data and enqueues creating or updating the DnsEntry" do
    parser = Minitest::Mock.new
    parser.expect(
      :call,
      Result.new([%w[ads.com 0.0.0.0], %w[more-ads.com 0.0.0.0]]),
      [@list]
    )
    worker = Minitest::Mock.new
    worker.expect(
      :perform_async,
      :ret_val,
      ["ads.com", "0.0.0.0", @blocklist.id]
    )
    worker.expect(
      :perform_async,
      :ret_val,
      ["more-ads.com", "0.0.0.0", @blocklist.id]
    )

    described_class.new.perform(@list, @blocklist.id, parser, worker)

    parser.verify
    worker.verify
  end

  test "it fails loudly when the blocklist can't be parsed" do
    failing_parser = Minitest::Mock.new
    failing_parser.expect(
      :call,
      Result.new(nil, StandardError.new("parsing failed")),
      [@list]
    )

    assert_raises "StandardError" do
      described_class.new.perform(@list, @blocklist.id, failing_parser)
    end

    failing_parser.verify
  end
end
