class EventsController < ApplicationController
  before_action :set_event, only: [:show, :edit, :update, :destroy]

  # GET /events
  # GET /events.json
  def index
    @events = Event.all
  end

  # GET /events/1
  # GET /events/1.json
  def show
    @going = @event.attendees.where(status: 1)
    @declined = @event.attendees.where(status: 2)
    @invited = @event.attendees.where(status: 3)
    
    @invalid_invitees = Array.new
    Attendee.where(event: @event).find_each do |attendee|
      @invalid_invitees.push(attendee.user)
    end
    @invitable_users = User.all - @invalid_invitees
    @invitable_users.delete(current_user)
    
    @attendee = Attendee.where("event_id = ? AND user_id = ?", @event.id, current_user.id)

  end

  # GET /events/new
  def new
    @event = Event.new
  end

  # GET /events/1/edit
  def edit
  end

  # POST /events
  # POST /events.json
  def create
    @event = Event.new(event_params)
    @event.generate_filename
    @event.creator = current_user
    @event.date_time = DateTime.strptime(params[:event][:date_time], '%m/%d/%Y %l:%M %p')

    @uploaded_io = params[:event][:uploaded_file]
    
    respond_to do |format|
      if @event.save
        Dir.mkdir(Rails.root.join('public', 'images', 'events', @event.id.to_s))
        File.open(Rails.root.join('public', 'images', 'events', @event.id.to_s, @event.image_filename), 'wb') do |file|
            file.write(@uploaded_io.read)
        end
        format.html { redirect_to @event, notice: 'Event was successfully created.' }
        format.json { render :show, status: :created, location: @event }
      else
        format.html { render :new }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /events/1
  # PATCH/PUT /events/1.json
  def update
    if @event.image_filename == 'default_event.jpg'
      Dir.mkdir(Rails.root.join('public', 'images', 'events', @event.id.to_s))
      @event.generate_filename
    end
    @uploaded_io = params[:event][:uploaded_file]
    if @uploaded_io
      File.open(Rails.root.join('public', 'images', 'events', @event.id.to_s, @event.image_filename), 'wb') do |file|
          file.write(@uploaded_io.read)
      end
    end
    @event.date_time = DateTime.strptime(params[:event][:date_time], '%m/%d/%Y %l:%M %p')
    
    respond_to do |format|
      if @event.update(event_params)
        format.html { redirect_to @event, notice: 'Event was successfully updated.' }
        format.json { render :show, status: :ok, location: @event }
      else
        format.html { render :edit }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /events/1
  # DELETE /events/1.json
  def destroy
    @event.destroy
    FileUtils.rm_rf(Rails.root.join('public', 'images', 'events', @event.id.to_s))
    respond_to do |format|
      format.html { redirect_to events_url, notice: 'Event was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_event
      @event = Event.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def event_params
      params.require(:event).permit(:title)
    end
end
