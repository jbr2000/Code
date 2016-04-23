class Tag < ActiveRecord::Base
  belongs_to :image
  validates_presence_of :image
end
