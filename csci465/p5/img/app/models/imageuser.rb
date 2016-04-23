class Imageuser < ActiveRecord::Base
  validates_presence_of :user, :image
  belongs_to :image
  belongs_to :user
end
