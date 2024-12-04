class PurchaseInformationsForm
  include ActiveModel::Model
  attr_accessor :post_code, :item_id,  :shipping_prefecture_id, :municipality, :street_address, :user_id,:building_name,
  :telephone,:token

  with_options presence: true do
   # 数字3桁、ハイフン、数字4桁の並びのみ許可する
   validates :post_code, format: {with: /\A[0-9]{3}-[0-9]{4}\z/, message: "is invalid. Include hyphen(-)"}
   # 0以外の整数を許可する
   validates :shipping_prefecture_id, numericality: {other_than: 0, message: "can't be blank"}
   validates :municipality
   validates :street_address
   validates :telephone,format: { with: /\A\d{10,11}\z/,message: "is invalid. Include hyphen(-)"}
   validates :user_id
   validates :item_id
   validates :token
 end

 def save
  purchase_information = PurchaseInformation.create(item_id: item_id.to_i, user_id: user_id)
  # 住所を保存する user_id: user_id)
  # 住所を保存する
  Shipping.create(post_code: post_code, shipping_prefecture_id: shipping_prefecture_id, municipality: municipality, street_address: street_address, 
   building_name: building_name,telephone: telephone, purchase_information_id: purchase_information.id)
end
  

end
