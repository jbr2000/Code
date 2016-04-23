require 'test_helper'

class ShiftTest < ActiveSupport::TestCase
  def setup
    @shift = Shift.new(user_id: 1, start_time: "2000-01-01 09:00", end_time: "2000-01-01 17:00")
  end

  test "shoud save valid shift" do
    assert @shift.save, "did not save valid user"
  end
end
