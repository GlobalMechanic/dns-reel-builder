class Clip < ActiveRecord::Base
	has_paper_trail
  has_attached_file :thumbnail

  attr_accessible :description, :name, :title, :thumbnail, :video, :image

  validates :name,  :presence => true
  validates :title, :presence => true,
                    :length => { :minimum => 5 }
  validates :video, :presence => true
  validates :image, :presence => true
end
