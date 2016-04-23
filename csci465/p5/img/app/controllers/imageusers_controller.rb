class ImageusersController < ApplicationController
  before_action :get_image, only: [:create, :destroy]
  
  def create
    @imageuser = Imageuser.create(imageuser_params)
    @imageuser.user_id = params[:imageuser][:user_id]
    @imageuser.image_id = flash[:image_id]
    unless Imageuser.exists?(user_id: @imageuser.user_id, image_id: @imageuser.image_id)
      @imageuser.save
    else
      flash[:notice] = User.find(@imageuser.user_id).name.to_s + " already has access to this image."
    end
    redirect_to edit_image_path(@image)
  end
  
  def destroy
    @imageuser = Imageuser.find(params[:id])
    @imageuser.destroy
    redirect_to edit_image_path(@image)
  end
  
  private
  def get_image
    @image = Image.find(flash[:image_id])
  end
  
  def imageuser_params
    params[:imageuser]
    params.permit(:user_id, :image_id)
  end
end