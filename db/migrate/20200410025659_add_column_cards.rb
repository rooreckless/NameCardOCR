class AddColumnCards < ActiveRecord::Migration[5.2]
  def change
    add_reference :cards, :group, index: true
  end
end
