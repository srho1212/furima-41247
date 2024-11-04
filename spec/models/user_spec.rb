require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'ユーザー新規登録' do
    it 'nicknameが空では登録できない' do
      user = User.new(nickname: '', email: 'test@example', password: '000000', password_confirmation: '000000',
                      family_name: '000000', first_name: '000000', family_name_kana: '000000', first_name_kana: '000000', birthday: '000000')
      user.valid?
      expect(user.errors.full_messages).to include("Nickname can't be blank")
    end

    it 'emailが空では登録できない' do
      user = User.new(nickname: '00000', email: '', password: '000000', password_confirmation: '000000', family_name: '000000',
                      first_name: '000000', family_name_kana: '000000', first_name_kana: '000000', birthday: '000000')
      user.valid?
      expect(user.errors.full_messages).to include("Email can't be blank")
    end

    before do
      @user = User.create(
        email: 'test@example.com',
        password: 'password123',
        password_confirmation: 'password123',
        nickname: 'TestUser',
        family_name: '田中',
        first_name: '太郎',
        family_name_kana: 'タナカ',
        first_name_kana: 'タロウ',
        birthday: '2000-01-01'
      )
    end

    it 'メールアドレスが一意であること' do
      another_user = User.new(
        email: 'test@example.com',
        password: 'password123',
        password_confirmation: 'password123',
        nickname: 'AnotherUser',
        family_name: '佐藤',
        first_name: '次郎',
        family_name_kana: 'サトウ',
        first_name_kana: 'ジロウ',
        birthday: '2000-01-02'
      )
      another_user.valid?
      expect(another_user.errors.full_messages).to include('Email has already been taken')
    end

    it 'メールアドレスは、@を含む必要があること。' do
      user = User.new(email: 'invalidemail', password: 'password', password_confirmation: 'password')
      user.valid?
      expect(user.errors.full_messages).to include('Email is invalid')
    end

    it 'パスワードが必須であること' do
      user = User.new(email: 'example@example.com', password: '')
      user.valid?
      expect(user.errors.full_messages).to include("Password can't be blank")
    end

    it 'パスワードは、6文字以上での入力が必須であること' do
      user = User.new(email: 'example@example.com', password: 'short')
      user.valid?
      expect(user.errors.full_messages).to include('Password is too short (minimum is 6 characters)')
    end

    it 'パスワードは半角英数字混合であること' do
      user = User.new(
        email: 'new@example.com',
        password: 'password', # 数字が含まれていない
        password_confirmation: 'password',
        nickname: 'NewUser',
        family_name: '田中',
        first_name: '太郎',
        family_name_kana: 'タナカ',
        first_name_kana: 'タロウ',
        birthday: '2000-01-01'
      )
      user.valid?
      expect(user.errors.full_messages).to include('Password は半角英数字混合で入力してください')
    end

    it 'パスワードとパスワード（確認）は、値の一致が必須であること。' do
      user = User.new(email: 'example@example.com', password: 'password', password_confirmation: 'different')
      user.valid?
      expect(user.errors.full_messages).to include("Password confirmation doesn't match Password")
    end

    it '名字(全角)は、全角（漢字・ひらがな・カタカナ）での入力が必須であること' do
      user = User.new(
        email: 'new@example.com',
        password: 'password123',
        password_confirmation: 'password123',
        nickname: 'NewUser',
        family_name: 'ﾔﾏﾀﾞ',
        first_name: '太郎',
        family_name_kana: 'ヤマダ',
        first_name_kana: 'タロウ',
        birthday: '2000-01-03'
      )
      user.valid?
      expect(user.errors.full_messages).to include('Family name は全角（漢字・ひらがな・カタカナ）で入力してください')
    end

    it '名前(全角)は、全角（漢字・ひらがな・カタカナ）での入力が必須であること' do
      user = User.new(
        email: 'new@example.com',
        password: 'password123',
        password_confirmation: 'password123',
        nickname: 'NewUser',
        family_name: '山',
        first_name: 'ﾀﾛｳ',
        family_name_kana: 'ヤマダ',
        first_name_kana: 'タロウ',
        birthday: '2000-01-03'
      )
      user.valid?
      expect(user.errors.full_messages).to include('First name は全角（漢字・ひらがな・カタカナ）で入力してください')
    end

    it '名字カナ(全角)は、全角（カタカナ）での入力が必須であること。' do
      user = User.new(
        email: 'new@example.com',
        password: 'password123',
        password_confirmation: 'password123',
        nickname: 'NewUser',
        family_name: '山田',
        first_name: '太郎',
        family_name_kana: 'ﾔﾏﾀﾞ',
        first_name_kana: 'タロウ',
        birthday: '2000-01-03'
      )
      user.valid?
      expect(user.errors.full_messages).to include('Family name kana は全角（カタカナ）で入力してください')
    end

    it 'お名前カナ(全角)は、全角（カタカナ）での入力が必須であること。' do
      user = User.new(
        email: 'new@example.com',
        password: 'password123',
        password_confirmation: 'password123',
        nickname: 'NewUser',
        family_name: '山田',
        first_name: '太郎',
        family_name_kana: 'ヤマダ',
        first_name_kana: 'ﾀﾛｳ',
        birthday: '2000-01-03'
      )
      user.valid?
      expect(user.errors.full_messages).to include('First name kana は全角（カタカナ）で入力してください')
    end

    it '名字が空では登録できない' do
      user = User.new(nickname: '0000', email: 'test@example', password: '000000', password_confirmation: '000000',
                      family_name: '', first_name: '000000', family_name_kana: '000000', first_name_kana: '', birthday: '')
      user.valid?
      expect(user.errors.full_messages).to include("Family name can't be blank")
    end

    it '名前が空では登録できない' do
      user = User.new(nickname: '0000', email: 'test@example', password: '000000', password_confirmation: '000000',
                      family_name: '000000', first_name: '', family_name_kana: '000000', first_name_kana: '', birthday: '')
      user.valid?
      expect(user.errors.full_messages).to include("First name can't be blank")
    end

    it '名字（フリガナ）が空では登録できない' do
      user = User.new(nickname: '0000', email: 'test@example', password: '000000', password_confirmation: '000000',
                      family_name: '000000', first_name: '000000', family_name_kana: '', first_name_kana: '', birthday: '')
      user.valid?
      expect(user.errors.full_messages).to include("Family name kana can't be blank")
    end

    it '名前（フリガナ）が空では登録できない' do
      user = User.new(nickname: '0000', email: 'test@example', password: '000000', password_confirmation: '000000',
                      family_name: '000000', first_name: '000000', family_name_kana: '000000', first_name_kana: '', birthday: '')
      user.valid?
      expect(user.errors.full_messages).to include("First name kana can't be blank")
    end

    it '誕生日が空では登録できない' do
      user = User.new(nickname: '0000', email: 'test@example', password: '000000', password_confirmation: '000000',
                      family_name: '000000', first_name: '000000', family_name_kana: '000000', first_name_kana: '000000', birthday: '')
      user.valid?
      expect(user.errors.full_messages).to include("Birthday can't be blank")
    end
  end
end
