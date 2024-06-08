# spec/models/user_spec.rb
require 'rails_helper'

RSpec.describe User, type: :model do
  describe "user creation" do
    it "creates a new user" do
      user = create(:user, email: 'test@example.com', password: 'password123', password_confirmation: 'password123')
      expect(user).to be_valid
    end
  end
end
