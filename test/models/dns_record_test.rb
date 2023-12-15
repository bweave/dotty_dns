require "test_helper"

class DnsRecordTest < ActiveSupport::TestCase
  test ".wildcards " do
    expected = [dns_records(:wildcard)]
    actual = described_class.wildcards
    assert_equal expected, actual
  end

  test ".not_wildcards" do
    expected = [dns_records(:one), dns_records(:two)]
    actual = described_class.not_wildcards
    assert_equal expected, actual
  end
end
