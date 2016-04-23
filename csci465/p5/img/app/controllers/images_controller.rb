class ImagesController < ApplicationController
  before_action :set_image, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @images = Image.all
    @user_images = Image.where(user: current_user)
    @public_images = Image.where(public: 1)
    @accessible_images = current_user.images
    respond_with(@images)
  end

  def show
    respond_with(@image)
  end

  def new
    @image = Image.new
    respond_with(@image)
  end

  def edit
    @users_to_add = User.where.not(id: current_user.id)
    @users_to_deny = Image.find(@image.id).users
    @users_to_add = @users_to_add - @users_to_deny
    respond_with(@image)
  end

 def create
    @image = Image.new(image_params)
    @image.generate_filename
    @image.user = current_user

    @uploaded_io = params[:image][:uploaded_file]
   
    File.open(Rails.root.join('public', 'images', @image.filename), 'wb') do |file|
        file.write(@uploaded_io.read)
    end

    if @image.save
      redirect_to @image, notice: 'Image was successfully created.'
    else
      render :new
    end
  end

  def update
    @uploaded_io = params[:image][:uploaded_file]
    if @uploaded_io
      File.open(Rails.root.join('public', 'images', @image.filename), 'wb') do |file|
        file.write(@uploaded_io.read)
      end
    end
    @image.public = params[:image][:public]
    @image.save
    redirect_to(edit_image_path(@image))
  end

  def destroy
    @image.destroy
    respond_with(@image)
  end

  private
    def set_image
      @image = Image.find(params[:id])
    end
  
    def image_params
      params.permit(:public, :filename, :uploaded_file, :name)
    end
end
