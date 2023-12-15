require "test_helper"

class CreateOrUpdateDnsRecordWorkerTest < ActiveSupport::TestCase
  test "it creates a DnsRecord for the given attributes" do
    assert_changes "DnsRecord.count", 1 do
      CreateOrUpdateDnsRecordWorker.new.perform(
        "excellent-ads.com",
        "0.0.0.0",
        blocklists(:one).id
      )
    end
  end

  test "it updates the blocklist if the domain already exists" do
    blocklist = blocklists(:two)
    dns_record = dns_records(:one)

    assert_no_changes "DnsRecord.count" do
      assert_changes "dns_record.reload.blocklist_id", to: blocklist.id do
        CreateOrUpdateDnsRecordWorker.new.perform(
          dns_record.domain,
          "0.0.0.0",
          blocklist.id
        )
      end
    end
  end

  test "it update the ip_address if the domain already exists" do
    dns_record = dns_records(:one)
    ip_address = "127.0.0.1"

    assert_no_changes "DnsRecord.count" do
      assert_changes "dns_record.reload.ip_address", to: ip_address do
        CreateOrUpdateDnsRecordWorker.new.perform(
          dns_record.domain,
          ip_address,
          dns_record.blocklist_id
        )
      end
    end
  end
end
