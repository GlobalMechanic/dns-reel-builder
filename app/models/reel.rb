class Reel < ActiveRecord::Base
  belongs_to :user
  attr_accessible :title

  has_many :reel_clips, :dependent => :delete_all
  has_many :clips, :through => :reel_clips
end
