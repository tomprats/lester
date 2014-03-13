class Tag < ActiveRecord::Base
  has_many :taggables
end
