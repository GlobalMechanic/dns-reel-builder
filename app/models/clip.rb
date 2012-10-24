class Clip < ActiveRecord::Base
  attr_accessible :description, :name, :title

  validates :name,  :presence => true
  validates :title, :presence => true,
                    :length => { :minimum => 5 }
end
