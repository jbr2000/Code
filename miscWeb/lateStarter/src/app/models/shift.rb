class Shift < ActiveRecord::Base
  validates :start_time, :end_time, presence: true
  belongs_to :user
  has_one :swap

  def start_before_end?
    :start_time.to_i < :end_time.to_i
  end

  def swap_status
    if Swap.exists?(shift_id: self.id)
      swap = Swap.where(shift_id: self.id).first!
      if swap.taker
        return "pending"
      end
      return "up"
    else
      return "down"
    end
  end

  def pretty_time
    s_time = DateTime.strptime(self.start_time, "%Y-%m-%d %H:%M")
    s_time = s_time.strftime("%l:%M %P")
    e_time = DateTime.strptime(self.end_time, "%Y-%m-%d %H:%M")
    e_time = e_time.strftime("%l:%M %P")
    s_time + " - " + e_time
  end

  def pretty_date
    date = DateTime.strptime(self.start_time, "%Y-%m-%d %H:%M")
    date = date.strftime("%A, %B %e")
    date
  end
end
