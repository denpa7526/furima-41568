class CreateItems < ActiveRecord::Migration[7.0]
  def change
    create_table :items do |t|
      t.string :item_name,         null: false
      t.text :item_info,           null: false
      t.integer :category_id,      null: false
      t.integer :condition_id,     null: false
      t.integer :shopping_fee_id,  null: false
      t.integer :prefecture_id,    null: false
      t.integer :delivery_time_id, null: false
      t.integer :price,            null: false
      t.references :user,          null: false, foreign_key: true
      t.timestamps
    end
  end
end
