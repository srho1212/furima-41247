class Item < ApplicationRecord
  belongs_to :user
  has_one_attached :item_image
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :category
  belongs_to_active_hash :status
  belongs_to_active_hash :delivery_day
  belongs_to_active_hash :shipping_prefecture
  belongs_to_active_hash :shipping_fee


#空の投稿を保存できないようにする


#ジャンルの選択が「---」の時は保存できないようにする
validates :category_id, presence: true,numericality: { other_than: 1 , message: "can't be blank"}
validates :status_id, presence: true,numericality: { other_than: 1 , message: "can't be blank"}
validates :delivery_day_id, presence: true,numericality: { other_than: 1 , message: "can't be blank"}
validates :shipping_prefecture_id, presence: true,numericality: { other_than: 1 , message: "can't be blank"}
validates :shipping_fee_id,presence: true, numericality: { other_than: 1 , message: "can't be blank"}

validates :price,presence: true,numericality: { greater_than_or_equal_to: 300, less_than_or_equal_to: 9999999 }
validates :price, format: { with: /\A[0-9]+\z/, message: "は半角数値で入力してください" }
validates :item_name,presence: true
validates :item_description,presence: true
validates :item_image, presence: true
validates :price, presence: true, numericality: { greater_than_or_equal_to: 300, less_than_or_equal_to: 9_999_999 }



end
