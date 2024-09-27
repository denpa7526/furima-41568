class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  with_options presence: true do
    validates :nickname
    validates :user_birth_date

    with_options format: { with: /\A[ぁ-んァ-ヶ一-龥々ー]+\z/, message: 'is invalid. Input full-width characters.' } do
      validates :last_name
      validates :first_name
    end

    with_options format: { with: /\A[ァ-ヶー]+\z/, message: 'is invalid. Input full-width katakana characters.' } do
      validates :last_name_kana
      validates :first_name_kana
    end
  end

  # validates :encrypted_password, format: { with: /\A[a-z0-9]+\z/i }

  VALID_PASSWORD_REGEX = /\A(?=.*[a-zA-Z])(?=.*\d)[a-zA-Z\d]{6,}\z/
  validates :password, format: { with: VALID_PASSWORD_REGEX, message: 'is invalid. Include both letters and numbers' }
end
