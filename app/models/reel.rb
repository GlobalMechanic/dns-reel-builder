class Reel < ActiveRecord::Base
  belongs_to :user
  attr_accessible :title
  has_and_belongs_to_many :clips
end
