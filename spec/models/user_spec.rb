require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:username) }
    it { should validate_presence_of(:password) }

    it 'validates uniqueness of username' do
      create(:user, username: 'test_user')
      user = User.new(username: 'test_user', password: 'password123')
      expect(user).not_to be_valid
      expect(user.errors[:username]).to include('has already been taken')
    end
  end

  describe 'password encryption' do
    it 'encrypts the password' do
      user = User.create(username: 'test_user', password: 'password123')
      expect(user.password_digest).not_to eq('password123')
    end
  end
end
