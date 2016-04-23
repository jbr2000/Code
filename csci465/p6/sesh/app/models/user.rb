class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :events, foreign_key: "creator_id"
  
  def generate_filename
    self.profile_picture = (0...8).map { (65 + rand(26)).chr }.join
  end
  
end