require "application_system_test_case"

class DnsRecordsTest < ApplicationSystemTestCase
  setup do
    @dns_record = dns_records(:one)
  end

  test "visiting the index" do
    visit dns_records_url
    assert_selector "h1", text: "Dns records"
  end

  test "should create dns record" do
    visit dns_records_url
    click_on "New dns record"

    fill_in "Domain", with: @dns_record.domain
    fill_in "Ip address", with: @dns_record.ip_address
    click_on "Create Dns record"

    assert_text "Dns record was successfully created"
    click_on "Back"
  end

  test "should update Dns record" do
    visit dns_record_url(@dns_record)
    click_on "Edit this dns record", match: :first

    fill_in "Domain", with: @dns_record.domain
    fill_in "Ip address", with: @dns_record.ip_address
    click_on "Update Dns record"

    assert_text "Dns record was successfully updated"
    click_on "Back"
  end

  test "should destroy Dns record" do
    visit dns_record_url(@dns_record)
    click_on "Destroy this dns record", match: :first

    assert_text "Dns record was successfully destroyed"
  end
end
