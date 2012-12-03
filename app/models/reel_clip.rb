class ReelClip < ActiveRecord::Base
  attr_accessible :clip_id, :reel_id, :weight
  belongs_to :clip
  belongs_to :reel
end
