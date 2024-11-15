require 'rails_helper'

RSpec.describe Item, type: :model do
  before do
    @item = FactoryBot.build(:item)
  end

  describe '商品出品登録' do
    context '出品登録できるとき' do
      it '全ての項目が入力されていれば新規登録できる' do
        expect(@item).to be_valid
      end
    end


    context '出品登録できないとき' do
      it '商品名が空では登録できない' do
        @item.item_name = ''
        @item.valid?
        expect(@item.errors.full_messages).to include "Item name can't be blank"
      end

      it '商品説明が空では登録できない' do
        @item.item_description = ''
        @item.valid?
        expect(@item.errors.full_messages).to include "Item description can't be blank"
      end

      it 'カテゴリーが空では登録できない' do
        @item.category_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include "Category can't be blank"
      end

      it '商品の状態が空では登録できない' do
        @item.status_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include "Status can't be blank"
      end

      it '配送料の負担が空では登録できない' do
        @item.shipping_fee_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include "Shipping fee can't be blank"
      end

      it '配送元の地域が空では登録できない' do
        @item.shipping_prefecture_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include "Shipping prefecture can't be blank"
      end

      it '配達日数が空では登録できない' do
        @item.delivery_day_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include "Delivery day can't be blank"
      end

      it '価格が空では登録できない' do
        @item.price = ''
        @item.valid?
        expect(@item.errors.full_messages).to include "Price can't be blank"
      end

      it '価格は￥300～￥9,999,999の間のみ保存が可能' do
        @item.price = 299
        @item.valid?
        expect(@item.errors.full_messages).to include "Price must be greater than or equal to 300"
      end

      it '価格は半角数のみ保存が入力可能' do
        @item.price = '１０００'
        @item.valid?
        expect(@item.errors.full_messages).to include "Price is not a number"
      end

      it '商品画像をつけることが必須' do
        @item.image = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Image can't be blank")
      end
    end
  end
end