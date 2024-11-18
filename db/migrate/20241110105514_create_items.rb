class CreateItems < ActiveRecord::Migration[7.0]
  def change
    create_table :items do |t|
      t.string     :item_name,              null: false, default: ""
      t.integer    :category_id,            null: false
      t.integer    :status_id,              null: false
      t.integer    :price,                  null: false
      t.integer    :delivery_day_id,        null: false
      t.integer    :shipping_prefecture_id, null: false
      t.integer    :shipping_fee_id,        null: false
      t.text       :item_description,       null: false
      t.references :user,                   null: false, foreign_key: true

      t.timestamps
    end
  end
end