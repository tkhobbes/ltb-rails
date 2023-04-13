require 'rails_helper'

RSpec.describe User do
  describe 'validations and database constraints' do
    context 'validations' do
      it 'is not valid unless an e-mail is given' do
        user = User.new(password: 'password')
        expect(user).to_not be_valid
      end

      it 'is valid if e-mail is given' do
        user = User.new(email: 'jdoe@example.com', password: 'password')
        expect(user).to be_valid
      end

      it 'cannot have 2 users with the same e-mail address' do
        create(:user)
        user = User.new(email: 'jdoe@example.com', password: 'password')
        expect(user).not_to be_valid
      end
    end
  end
end
