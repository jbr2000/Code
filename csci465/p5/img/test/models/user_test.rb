require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.create(email: 'test@test.com', name: 'test', password: 'password', password_confirmation: 'password')
  end

  test 'save_user' do
    assert @user.save, 'did not save user'
  end
end
