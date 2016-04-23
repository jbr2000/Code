class MyDevise::RegistrationsController < Devise::RegistrationsController 
  def new
    super
  end
  
  def create
    @user = User.new(user_params)
    @user.generate_filename

    @uploaded_io = params[:user][:uploaded_file]
    if @uploaded_io
      File.open(Rails.root.join('public', 'images', 'users', @user.profile_picture), 'wb') do |file|
        file.write(@uploaded_io.read)
      end
    end
    @user.save
    redirect_to root_path
  end
  
  def update
    super
  end
  
  private
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end
    
end