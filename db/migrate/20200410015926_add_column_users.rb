class AddColumnUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :belonging_group_id, :integer
    add_column :users, :owned_group_id, :integer
  end
end
