class AddBlocklistIdToDnsRecords < ActiveRecord::Migration[7.1]
  def change
    add_reference :dns_records, :blocklist, foreign_key: true
  end
end
