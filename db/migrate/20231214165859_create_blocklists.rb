class CreateBlocklists < ActiveRecord::Migration[7.1]
  def change
    create_table :blocklists do |t|
      t.string :url, null: false, index: { unique: true }
      t.string :title

      t.timestamps
    end
  end
end
