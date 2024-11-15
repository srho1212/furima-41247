FactoryBot.define do
  factory :item do
    item_name { "サンプルアイテム" }
    category_id { 2 } # 有効なID
    status_id { 2 } # 有効なID
    price { 3000 }
    delivery_day_id { 2 } # 有効なID
    shipping_prefecture_id { 2 } # 有効なID
    shipping_fee_id { 2 } # 有効なID
    item_description { "これはサンプルの説明です。" }

    association :user, factory: :user

    after(:build) do |item|
      item.image.attach(io: File.open(Rails.root.join('spec/fixtures/files/sample_image.png')), filename: 'sample_image.png', content_type: 'image/png')
    end
  end
end