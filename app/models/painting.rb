class Painting < ActiveRecord::Base
  belongs_to :gallery
  has_many :comments, as: :commentable
  has_many :taggables, as: :tagged
  has_many :tags, through: :taggables

  validates :title, uniqueness: true
  validates :gallery_id, :url, :title, presence: true
end
