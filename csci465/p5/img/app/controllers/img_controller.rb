class ImgController < ApplicationController
  def home
    unless user_signed_in?
      redirect_to new_user_session_path
    else
      redirect_to images_path
    end
  end
end