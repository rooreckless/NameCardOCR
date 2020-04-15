class CreateGroups < ActiveRecord::Migration[5.2]
  def change
    create_table :groups do |t|
      t.string :name,              null: false, default: ""
      t.references :user,          null: false, foreign_key: true
      t.string :password_digest,    null: false, foreign_key: true
      t.timestamps
    end
  end
end
