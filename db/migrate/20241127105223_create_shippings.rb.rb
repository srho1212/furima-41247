class CreateShippings < ActiveRecord::Migration[7.0]
  def change
    create_table :shippings do |t|
      t.string     :post_code, null: false
      t.integer    :shipping_prefecture_id , null: false
      t.string     :municipality, null: false
      t.string     :street_address, null: false
      t.string     :building_name
      t.string     :telephone,null: false
      t.references :purchase_information,      null: false, foreign_key: true

      t.timestamps
    end
  end
end
