require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.new(first_name: "Spencer",
                      last_name: "McWilliams",
                       password: "foo",
                password_digest: "foo")
  end

  test "should save valid user" do
    assert @user.save, "saved invalid user"
  end

  test "should not save user with invalid password" do
    @user.password = "foo"
    @user.password_confirmation = "fail"
    assert_not @user.save, "saved user with incorrect password"
  end

  test "should get full_name" do
    assert_equal("Spencer McWilliams", @user.full_name, "did not provide full_name")
  end
end
