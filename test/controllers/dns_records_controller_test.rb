require "test_helper"

class DnsRecordsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @dns_record = dns_records(:one)
  end

  test "should get index" do
    get dns_records_url
    assert_response :success
  end

  test "should get new" do
    get new_dns_record_url
    assert_response :success
  end

  test "should create dns_record" do
    assert_difference("DnsRecord.count") do
      post dns_records_url, params: { dns_record: { domain: @dns_record.domain, ip_address: @dns_record.ip_address } }
    end

    assert_redirected_to dns_record_url(DnsRecord.last)
  end

  test "should show dns_record" do
    get dns_record_url(@dns_record)
    assert_response :success
  end

  test "should get edit" do
    get edit_dns_record_url(@dns_record)
    assert_response :success
  end

  test "should update dns_record" do
    patch dns_record_url(@dns_record), params: { dns_record: { domain: @dns_record.domain, ip_address: @dns_record.ip_address } }
    assert_redirected_to dns_record_url(@dns_record)
  end

  test "should destroy dns_record" do
    assert_difference("DnsRecord.count", -1) do
      delete dns_record_url(@dns_record)
    end

    assert_redirected_to dns_records_url
  end
end
