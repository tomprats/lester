class Gallery < ActiveRecord::Base
  belongs_to :artist, class_name: "User"
  belongs_to :cover, class_name: "Painting"
  has_many :paintings, dependent: :destroy
  has_many :comments, as: :commentable, dependent: :destroy
  has_many :taggables, as: :tagged
  has_many :tags, through: :taggables

  validates :title, uniqueness: true
  validates :title, presence: true

  def self.private
    where(private: true)
  end

  def self.public
    where(private: false)
  end

  def private?
    private
  end

  def public?
    !private
  end

  def cover
    super || paintings.first
  end
end
