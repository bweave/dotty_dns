require "test_helper"

class ParseBlocklistTest < ActiveSupport::TestCase
  test "it creates a new DnsEntry for each line of the blocklist" do
    blocklist = <<~BLOCKLIST
      0.0.0.0 ads.com
      0.0.0.0 all-the-ads.com
    BLOCKLIST
    expected = [%w[ads.com 0.0.0.0], %w[all-the-ads.com 0.0.0.0]]
    result = described_class.call(blocklist)

    assert result.ok?
    assert_equal expected, result.data
  end

  test "it ignores comments" do
    blocklist = <<~BLOCKLIST
      # a comment
        # an indented comment
      0.0.0.0 ads.com
    BLOCKLIST
    expected = [%w[ads.com 0.0.0.0]]
    result = described_class.call(blocklist)

    assert result.ok?
    assert_equal expected, result.data
  end

  test "it ignores trailing comments" do
    blocklist = <<~BLOCKLIST
      0.0.0.0 ads.com # a comment
    BLOCKLIST
    expected = [%w[ads.com 0.0.0.0]]
    result = described_class.call(blocklist)

    assert result.ok?
    assert_equal expected, result.data
  end

  test "it defaults ip_address to 0.0.0.0 for lists that only contain domains" do
    blocklist = <<~BLOCKLIST
      ads.com
      all-the-ads.com # comment
    BLOCKLIST
    expected = [%w[ads.com 0.0.0.0], %w[all-the-ads.com 0.0.0.0]]
    result = described_class.call(blocklist)

    assert result.ok?
    assert_equal expected, result.data
  end
end
