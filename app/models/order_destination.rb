class OrderDestination
  include ActiveModel::Model
  attr_accessor :post_code, :prefecture_id, :city, :addresses, :building, :phone_number, :user_id, :item_id, :token

  with_options presence: true do
    validates :post_code, format: { with: /\A[0-9]{3}-[0-9]{4}\z/, message: ' is invalid. Enter it as follows (e.g. 123-4567)' }
    validates :prefecture_id, numericality: { other_than: 0, message: "can't be blank" }
    validates :city
    validates :addresses
    validates :phone_number, format: { with: /\A\d{10,11}\z/, message: 'is invalid. Input only number' }
    validates :user_id
    validates :item_id
    validates :token
  end

  validate :phone_number_length_and_format

  def save
    order = Order.create(user_id:, item_id:)
    Destination.create(post_code:, prefecture_id:, city:, addresses:, building:,
                       phone_number:, order_id: order.id)
  rescue StandardError => e
    errors.add(:base, "Order save failed: #{e.message}")
    false
  end

  private

  def phone_number_length_and_format
    return unless phone_number.present?

    if phone_number.to_s.length < 10
      errors.add(:phone_number, 'is too short')
    elsif !phone_number.to_s.match(/\A\d{10,11}\z/)
      errors.add(:phone_number, 'is invalid. Input only number')
    end
  end
end
