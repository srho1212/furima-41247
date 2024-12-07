class PurchaseInformation < ApplicationRecord
  belongs_to :item
  belongs_to :user
  has_one    :shipping_destination
end
