class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  with_options presence: true do
    validates :nickname
    validates :user_birth_date

    with_options format: { with: /\A[ぁ-んァ-ヶ一-龥々ー]+\z/ } do
      validates :last_name
      validates :first_name
    end

    with_options format: { with: /\A[ァ-ヶー]+\z/ } do
      validates :last_name_kana
      validates :first_name_kana
    end
  end

  # validates :encrypted_password, format: { with: /\A[a-z0-9]+\z/i }

  VALID_PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]{6,}\z/i
  validates :password, format: { with: VALID_PASSWORD_REGEX }
end
