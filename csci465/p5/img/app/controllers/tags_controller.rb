class TagsController < ApplicationController
  before_action :set_tag, only: [:destroy]
  
  def create
    tag = Tag.create(tag_params)
    tag.value = params[:tag][:value].capitalize
    tag.image_id = params[:tag][:image_id]
    unless Tag.exists?(value: tag.value)
      tag.save
    else
      flash[:notice] = "Tag already exists!"
    end
    redirect_to image_path(Image.find(params[:tag][:image_id]))
  end
  
  def destroy
    @image = Image.find(@tag.image_id)
    @tag.destroy
    redirect_to image_path(@image)
  end
  
  def set_tag
    @tag = Tag.find(params[:id])
  end
  
  def tag_params
    params[:tag]
    params.permit(:image_id, :value)
  end
end