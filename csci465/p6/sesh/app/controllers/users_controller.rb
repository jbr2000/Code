class UsersController < ApplicationController
  before_action :set_user
  
  def show
    @upcoming_events = @user.events.where("date_time > :now", {now: DateTime.now})
    @past_events     = @user.events.where("date_time < :now", {now: DateTime.now})
  end
  
  def edit
  end
    
  def set_user
    @user = User.find(params[:id])
  end
  
end
