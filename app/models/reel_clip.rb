class ReelClip < ActiveRecord::Base
  attr_accessible :clip_id, :reel_slug, :order
  belongs_to :clip
  belongs_to :reel
end
