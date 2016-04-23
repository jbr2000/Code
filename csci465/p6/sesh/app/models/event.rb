class Event < ActiveRecord::Base
  belongs_to :creator, class_name: 'User'
  has_many :attendees

  validates_presence_of :creator, :title
  
  def generate_filename
    self.image_filename = (0...8).map { (65 + rand(26)).chr }.join
  end

end
