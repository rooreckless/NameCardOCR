class AddColumnEpisodes < ActiveRecord::Migration[5.2]
  def change
    add_column :episodes, :user_id, :integer
    add_column :episodes, :group_id, :integer
  end
end
