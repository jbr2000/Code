class Url < ActiveRecord::Base
  belongs_to :doi
  validates_presence_of :doi
end
