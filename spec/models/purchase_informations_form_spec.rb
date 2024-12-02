require 'rails_helper'

RSpec.describe PurchaseInformationsForm, type: :model do
  before do
    # デバッグ用のログを追加
      @user = FactoryBot.create(:user)
      @item = FactoryBot.create(:item, user: @user)
      @purchase_informations_form = FactoryBot.build(:purchase_informations_form, user_id: @user.id, item_id: @item.id, token: "sample_token")
  end

  describe '商品購入' do
    context '内容に問題ない場合' do
      it 'すべての値が正しく入力されていれば保存できること' do
        expect(@purchase_informations_form).to be_valid
      end

      it 'building_nameが空でも保存できること' do
        @purchase_informations_form.building_name = ''
        expect(@purchase_informations_form).to be_valid
      end
    end

    context '内容に問題がある場合' do
      it '郵便番号が空だと保存できないこと' do
        @purchase_informations_form.post_code = ''
        @purchase_informations_form.valid?
        expect(@purchase_informations_form.errors.full_messages).to include("Post code can't be blank")
      end

      it '郵便番号は「3桁ハイフン4桁」の半角文字列のみ保存可能なこと' do
        @purchase_informations_form.post_code = '1234567'
        @purchase_informations_form.valid?
        expect(@purchase_informations_form.errors.full_messages).to include("Post code is invalid. Include hyphen(-)")
      end

      it '都道府県を選択していないと保存できないこと' do
        @purchase_informations_form.shipping_prefecture_id = nil
        @purchase_informations_form.valid?
        expect(@purchase_informations_form.errors.full_messages).to include("Shipping prefecture can't be blank")
      end

      it '市町村が空だと保存できないこと' do
        @purchase_informations_form.municipality = nil
        @purchase_informations_form.valid?
        expect(@purchase_informations_form.errors.full_messages).to include("Municipality can't be blank")
      end

      it '番地が空だと保存できないこと' do
        @purchase_informations_form.street_address = nil
        @purchase_informations_form.valid?
        expect(@purchase_informations_form.errors.full_messages).to include("Street address can't be blank")
      end

      it '電話番号が空だと保存できないこと' do
        @purchase_informations_form.telephone = nil
        @purchase_informations_form.valid?
        expect(@purchase_informations_form.errors.full_messages).to include("Telephone can't be blank")
      end

      it '10桁以上11桁以内の半角数値のみ保存可能なこと（良い例：09012345678　良くない例：090-1234-5678）' do
        @purchase_informations_form.telephone = '090-1234-5678'
        @purchase_informations_form.valid?
        # 新しいエラーメッセージを期待
        expect(@purchase_informations_form.errors.full_messages).to include("Telephone is invalid. Include hyphen(-)")
      end

      it 'userが紐付いていないと保存できないこと' do
        @purchase_informations_form.user_id = nil
        @purchase_informations_form.valid?
        expect(@purchase_informations_form.errors.full_messages).to include("User can't be blank")
      end
    end
  end
end