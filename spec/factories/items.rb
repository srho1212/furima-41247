FactoryBot.define do
  factory :item do
    category_id {"メンズ" }
    status_id { "新品・未使用" }
    item_description { "赤" }
    item_name { "スーツ" }
    delivery_day_id { "1~2日で発送" }
    shipping_prefecture_id { "千葉県" }
    shipping_fee_id { "着払い" }
    price { "3000" }
    after(:build) do |item|
      item.image.attach(io: File.open(Rails.root.join('spec/fixtures/files/sample_image.png')), filename: 'sample_image.png', content_type: 'image/png')
    item_image { "2000-01-02" }
   end
 end
end

