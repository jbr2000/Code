class Doi < ActiveRecord::Base
  has_many :urls
  validates_uniqueness_of :name
end
