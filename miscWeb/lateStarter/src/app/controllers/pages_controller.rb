class PagesController < ApplicationController
  before_action :check_for_user

  def check_for_user
    if !session[:user_id]
      redirect_to(login_path)
    else
      @user = User.find(session[:user_id])
    end
  end

  def home
    @shifts = @user.shifts
  end

  def master_schedule
  end

  def edit
  end

  def swap_board
    @swaps = Swap.all
  end
end
