class CreateDnsQueries < ActiveRecord::Migration[7.1]
  def change
    create_table :dns_queries do |t|
      t.string :domain
      t.string :requested_by
      t.integer :dns_type
      t.integer :status
      t.string :reply_from
      t.integer :reply_type
      t.decimal :reply_time_ms, precision: 10, scale: 6

      t.timestamps
    end
  end
end
