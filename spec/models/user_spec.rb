require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

describe 'ユーザー新規登録' do
   context '新規登録できるとき' do
      it '全ての項目が入力されていれば新規登録できる' do
        expect(@user).to be_valid
      end
   end

   context '新規登録できないとき' do
      it 'nicknameが空では登録できない' do
        @user.nickname = ''
        @user.valid?
        expect(@user.errors.full_messages).to include "Nickname can't be blank"
      end

      it 'emailが空では登録できない' do
        @user.email = ''
        @user.valid?
        expect(@user.errors.full_messages).to include "Email can't be blank"
      end

      it 'メールアドレスが一意でないと登録できない' do
          @user.save
          another_user = FactoryBot.build(:user)
          another_user.email = @user.email
          another_user.valid?
          expect(another_user.errors.full_messages).to include('Email has already been taken')
      end

      it 'メールアドレスは、@を含む必要があること。' do
        @user.email = "testexample.com"
        @user.valid?
        expect(@user.errors.full_messages).to include("Email is invalid")
      end
  
      it 'パスワードとパスワード（確認）は、値の一致が必須であること。' do
        @user.password = 'password123'
        @user.password_confirmation = 'password321'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end
  
      it 'パスワードが空では登録できない' do
        @user.password = ""
        @user.password_confirmation = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("Password can't be blank")
      end
    
      it 'パスワードは、6文字以上での入力が必須であること' do
        @user.password = "1234q"
        @user.password_confirmation = "1234q"
        @user.valid?include('Password is too short (minimum is 6 characters)')
      end

      it '名字が空では登録できない' do
        @user.family_name = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("Family name can't be blank")
      end

      it '名字(全角)は、全角（漢字・ひらがな・カタカナ）での入力が必須であること' do
          @user.family_name = "aaa"
          @user.valid?
          expect(@user.errors.full_messages).to include('Family name は全角（漢字・ひらがな・カタカナ）で入力してください')
       end

      it '名前が空では登録できない' do
        @user.first_name = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("First name can't be blank")
      end

      it 'お名前カナ(全角)は、全角（カタカナ）での入力が必須であること。' do
        @user.first_name_kana = "たろう"
        @user.valid?
        expect(@user.errors.full_messages).to include("First name kana は全角（カタカナ）で入力してください")
      end

      it '名字（フリガナ）が空では登録できない' do
        @user.family_name_kana = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("Family name kana can't be blank")
      end

      it '名字カナ(全角)は、全角（カタカナ）での入力が必須であること。' do
        @user.family_name_kana = "aaaa"
        @user.valid?
        expect(@user.errors.full_messages).to include('Family name kana は全角（カタカナ）で入力してください')
     end

      it '名前(全角)は、全角（漢字・ひらがな・カタカナ）での入力が必須であること' do
        @user.first_name= "aaaa"
        @user.valid?
        expect(@user.errors.full_messages).to include('First name は全角（漢字・ひらがな・カタカナ）で入力してください')
     end

      it '名前（フリガナ）が空では登録できない' do
        @user.first_name_kana = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("First name kana can't be blank")
      end

      it '誕生日が空では登録できない' do
        @user.birthday= ""
        @user.valid?
        expect(@user.errors.full_messages).to include("Birthday can't be blank")
      end

      it '英字のみのパスワードでは登録できない' do
        @user.password= "aaaaaa"
        @user.valid?
        expect(@user.errors.full_messages).to include('Password は半角英数字混合で入力してください')
      end

      it '数字のみのパスワードでは登録できない' do
        @user.password= "111111"
        @user.valid?
        expect(@user.errors.full_messages).to include('Password は半角英数字混合で入力してください')
      end

      it '全角を含むパスワードでは登録できない' do
        @user.password= "１11111"
        @user.valid?
        expect(@user.errors.full_messages).to include('Password は半角英数字混合で入力してください')
      end
    end
  end
end