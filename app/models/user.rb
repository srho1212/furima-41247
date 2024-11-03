class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i    
  VALID_NAME_REGEX = /\A[ぁ-んァ-ヶ一-龥々]+\z/
  VALID_PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]+\z/i
  VALID_NAME_KANA_REGEX = /\A[ァ-ヶー－]+\z/


  validates :nickname, presence: true
  validates :family_name, presence: true, format: { with: /\A[ぁ-んァ-ヶ一-龥々ー]+\z/,message: "は全角（漢字・ひらがな・カタカナ）で入力してください" }
  validates :first_name, presence: true, format: { with: /\A[ぁ-んァ-ヶ一-龥々ー]+\z/,message: "は全角（漢字・ひらがな・カタカナ）で入力してください" }
  validates :family_name_kana, presence: true,format: { with: /\A[ァ-ヶー]+\z/,message: "は全角（漢字・ひらがな・カタカナ）で入力してください" }
  validates :first_name_kana, presence: true,format: { with: /\A[ァ-ヶー]+\z/ ,message: "は全角（漢字・ひらがな・カタカナ）で入力してください" }
  validates :birthday, presence: true     
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }, uniqueness: true
  validates :password, presence: true, length: { minimum: 6 }, format: { with: VALID_PASSWORD_REGEX, message: "は半角英数字混合で入力してください" }
  validates :family_name, :first_name, presence: true, format: { with: VALID_NAME_REGEX, message: "は全角（漢字・ひらがな・カタカナ ）で入力してください" }
  validates :family_name_kana, :first_name_kana, presence: true, format: { with: VALID_NAME_KANA_REGEX, message: "は全角（カタカナ）で入力してください" }
end

