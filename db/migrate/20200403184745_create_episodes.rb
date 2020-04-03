class CreateEpisodes < ActiveRecord::Migration[5.2]
  def change
    create_table :episodes do |t|
      t.text :content     ,defalt: ""
      t.string :when    ,defalt: ""
      t.string :where    ,defalt: ""
      t.references :card ,null: false ,foreign_key: true
      t.timestamps
    end
  end
end
