class Image < ActiveRecord::Base
  belongs_to :user
  has_many :imageusers
  has_many :tags
  has_many :users, through: :imageusers
  validates_presence_of :user
    
  def generate_filename
    self.filename = (0...8).map { (65 + rand(26)).chr }.join
  end
end