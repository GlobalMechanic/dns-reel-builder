class Reel < ActiveRecord::Base
  belongs_to :user
  attr_accessible :title

  has_many :reel_clips
  has_many :clips, :through => :reel_clips
end
