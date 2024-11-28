class AddUserIdToPurchaseInformations < ActiveRecord::Migration[7.0]
  def change
    add_column :purchase_informations, :user_id, :integer
  end
end
