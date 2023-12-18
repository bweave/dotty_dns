class AddStatusToBlocklists < ActiveRecord::Migration[7.1]
  def change
    add_column :blocklists, :status, :integer, default: 0
  end
end
