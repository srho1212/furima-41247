class PurchaseInformationsShippingDestination
  include ActiveModel::Model
  attr_accessor :post_code, :item_id, :post_code, :shipping_prefecture_id, :municipality, :street_address, :user_id,:building_name,
  :telephone,:purchase_information_id, :price

  with_options presence: true do
   # 数字3桁、ハイフン、数字4桁の並びのみ許可する
   validates :post_code, presence: true, format: {with: /\A[0-9]{3}-[0-9]{4}\z/, message: "is invalid. Include hyphen(-)"}
   # 0以外の整数を許可する
   validates :shipping_prefecture_id, numericality: {other_than: 0, message: "can't be blank"}
   validates :municipality, presence: true
   validates :street_address, presence: true
   validates :telephone, presence:true
   validates :item_id
 end

 def save
  # 寄付情報を保存し、変数donationに代入する
  purchase_information = PurchaseInformation.create(user_id: user_id)
  # 住所を保存する
  # donation_idには、変数donationのidと指定する
  Shipping.create(post_code: post_code, shipping_prefecture_id: shipping_prefecture_id, municipality: municipality, street_address: street_address, building_name: building_name, purchase_information_id: purchase_information.id)
end
  

end
