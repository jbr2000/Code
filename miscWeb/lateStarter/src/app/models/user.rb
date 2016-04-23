class User < ActiveRecord::Base
  validates_presence_of :first_name, :last_name, :password_digest
  has_many :shifts
  has_many :swaps
  has_secure_password

  def full_name
    first_name + " " + last_name
  end
end
