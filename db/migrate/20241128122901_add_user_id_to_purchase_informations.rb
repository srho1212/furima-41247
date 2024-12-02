class AddUserIdToPurchaseInformations < ActiveRecord::Migration[6.1]
  def change
    unless column_exists?(:purchase_informations, :user_id)
      add_column :purchase_informations, :user_id, :integer
    end
  end
end
