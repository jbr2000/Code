require 'test_helper'

class HomeControllerTest < ActionController::TestCase
  # test "the truth" do
  #   assert true
  # end

  test "sets start and end words" do
    assert_not(@start_word.to_s.empty?, "start_word is empty")
    assert_not(@end_word.to_s.empty?, "end_word is empty")
  end
end
