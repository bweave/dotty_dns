require "test_helper"

class FetchBlocklistTest < ActiveSupport::TestCase
  setup do
    @url = "http://example.com/blocklist.txt"
    @blocklist = <<~BLOCKLIST
      0.0.0.0 ads.com
      0.0.0.0 more-ads.com
    BLOCKLIST

    stub_request(:get, @url).to_return(status: 200, body: @blocklist)
  end

  test ".call fetches the blocklist from the provided url" do
    result = FetchBlocklist.call(@url)
    assert result.ok?
    assert_equal @blocklist, result.data
  end

  test ".call when it fails" do
    skip "write these tests when they're warranted"
  end
end
