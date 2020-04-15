class RemoveBelongingGroupIdFromUsers < ActiveRecord::Migration[5.2]
  def change
    remove_column :users, :belonging_group_id, :integer
  end
end
