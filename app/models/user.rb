class User < ActiveRecord::Base
  has_many :galleries, foreign_key: :artist_id
  has_many :paintings, through: :galleries
  has_many :comments

  def name?
    first_name && last_name
  end

  def name
    "#{first_name} #{last_name}"
  end

  def artist?
    artist
  end

  def admin?
    admin
  end
end
