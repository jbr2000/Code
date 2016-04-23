require 'test_helper'

class SwapTest < ActiveSupport::TestCase
  setup do
    @swap = Swap.new(owner_id: 519, taker_id: 519, shift_id: 1)
  end

  test "should save valid swap" do
    assert @swap.save, "did not save valid swap"
  end
  
end
