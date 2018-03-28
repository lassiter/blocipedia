require 'rails_helper'

RSpec.describe User, type: :model do
let(:user) { FactoryBot.create(:user) }
  context 'Validating Users' do
    describe '#email' do
        it 'should not validate as presence' do
          user.email = '' # invalid state
          user.valid? # run validations
          expect(user.errors[:email]).to eq(["can't be blank", "is invalid"]) # check for presence of error
        end
        it 'should not validate incorrectly formatted emails' do
          user.email = 'foo@bar' # valid state
          user.valid? # run validations
          user.errors[:email]
          puts user.errors[:email]
          expect(user.errors[:email]).to eq(["is invalid"]) # check for presence of error
        end
        it 'should validate as present and correctly formatted' do
          user.email = 'foo@bar.com' # valid state
          user.valid? # run validations
          expect(user.errors[:email]).to_not eq(["can't be blank", "is invalid"]) # check for absence of error
        end
    end
    describe '#password' do
      it 'should not validate as present' do
        FactoryBot.build(:user, password: "").should_not be_valid
      end
      it 'should not validate as complete' do
        FactoryBot.build(:user, password: "12345").should_not be_valid
      end
      it 'should validate as present and complete' do
        FactoryBot.build(:user, password: "123456").should be_valid
      end
    end
  end

end
