class AttendeesController < ApplicationController
  before_action :set_event, only: [:create]
  
  def new
    @attendee = Attendee.new
  end
  
  def create
    @attendee = Attendee.new(attendee_params)
    @attendee.event = @event
    @attendee.save
    redirect_to @event
  end
  
  def destroy
  end
  
  def going
    attendee = Attendee.find(flash[:attendee_id])
    attendee.status = 1
    attendee.save
    redirect_to(:back)
  end
  
  def decline
    attendee = Attendee.find(flash[:attendee_id])
    attendee.status = 2
    attendee.save
    redirect_to(:back)

  end
  
  private
    def attendee_params
      params.require(:attendee).permit(:user_id)
    end
    
    def set_event
      @event = Event.find(params[:event_id])
    end
  
end