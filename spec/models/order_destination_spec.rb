require 'rails_helper'

RSpec.describe OrderDestination, type: :model do
  before do
    user = FactoryBot.create(:user)
    item = FactoryBot.create(:item)
    @order_destination = FactoryBot.build(:order_destination, user_id: user.id, item_id: item.id)
  end

  describe '購入情報の保存' do

    context '内容に問題ない場合' do
      it 'すべての値が正しく入力されていれば保存可能' do
        expect(@order_destination).to be_valid
      end

      it 'buildingが空でも保存可能' do
        @order_destination.building = ''
        expect(@order_destination).to be_valid
      end
    end

    context '内容に問題がある場合' do
      it "tokenが空では登録できないこと" do
        @order_destination.token = nil
        @order_destination.valid?
        expect(@order_destination.errors.full_messages).to include("Token can't be blank")
      end

      it 'post_codeが空の場合は保存不可' do
        @order_destination.post_code = ''
        @order_destination.valid?
        expect(@order_destination.errors.full_messages).to include("Post code can't be blank")
      end

      it 'post_codeが8桁の半角数字のみの場合では保存不可' do
        @order_destination.post_code = '12345678'
        @order_destination.valid?
        expect(@order_destination.errors.full_messages).to include("Post code  is invalid. Enter it as follows (e.g. 123-4567)")
      end

      it 'post_codeが「3桁ハイフン4桁」の半角文字列でない場合は保存不可' do
        @order_destination.post_code = '1234567'
        @order_destination.valid?
        expect(@order_destination.errors.full_messages).to include("Post code  is invalid. Enter it as follows (e.g. 123-4567)")
      end

      it 'prefecture_idが空の場合は保存不可' do
        @order_destination.prefecture_id = 0
        @order_destination.valid?
        expect(@order_destination.errors.full_messages).to include("Prefecture can't be blank")
      end

      it 'cityが空の場合は保存不可' do
        @order_destination.city = ''
        @order_destination.valid?
        expect(@order_destination.errors.full_messages).to include("City can't be blank")
      end

      it 'addressesが空の場合は保存不可' do
        @order_destination.addresses = ''
        @order_destination.valid?
        expect(@order_destination.errors.full_messages).to include("Addresses can't be blank")
      end

      it 'phone_numberが空の場合は保存不可' do
        @order_destination.phone_number = ''
        @order_destination.valid?
        expect(@order_destination.errors.full_messages).to include("Phone number can't be blank")
      end

      it 'phone_numberが10桁以上11桁以内の半角数値でない場合は保存不可' do
        @order_destination.phone_number = '080-1234-5678'
        @order_destination.valid?
        expect(@order_destination.errors.full_messages).to include("Phone number is invalid. Input only number")
      end

      it 'userが紐付いていない場合は保存できない' do
        @order_destination.user_id = nil
        @order_destination.valid?
        expect(@order_destination.errors.full_messages).to include("User can't be blank")
      end

      it 'itemが紐付いていない場合は保存できない' do
        @order_destination.item_id = nil
        @order_destination.valid?
        expect(@order_destination.errors.full_messages).to include("Item can't be blank")
      end
    end

  end
end
