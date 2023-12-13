class CreateDnsRecords < ActiveRecord::Migration[7.1]
  def change
    create_table :dns_records do |t|
      t.string :domain, null: false, index: { unique: true }
      t.string :ip_address, null: false, default: "0.0.0.0"

      t.timestamps
    end
  end
end
