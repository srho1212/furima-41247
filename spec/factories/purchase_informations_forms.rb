FactoryBot.define do
  factory :purchase_informations_form do
        post_code { '123-4567' }
        shipping_prefecture_id { 2 }
        municipality { '東京都' }
        street_address { '1-1' }
        building_name { '東京ハイツ' }
        telephone { '09012345678' }
        token {"tok_abcdefghijk00000000000000000"}
      end
    
end
