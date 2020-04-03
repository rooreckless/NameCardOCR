class CreateCards < ActiveRecord::Migration[5.2]
  def change
    create_table :cards do |t|
      t.string :name            ,null: false, defalt: ""
      t.string :company         ,null: false, defalt: ""
      t.string :department      ,defalt: ""
      t.string :address         ,defalt: ""
      t.string :tel             ,defalt: ""
      t.string :email           ,defalt: ""
      t.text :apiresulttext     ,defalt: ""
      t.integer :apiresulthash  ,defalt: 0
      t.references :user        ,null: false, foreign_key: true
      t.timestamps
    end
  end
end
