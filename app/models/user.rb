require "bcrypt"

class User < ActiveRecord::Base
  include BCrypt

  has_many :galleries, foreign_key: :artist_id
  has_many :paintings, through: :galleries
  has_many :comments

  validates_presence_of :email, :encrypted_password
  validates_uniqueness_of :email

  def password
    @password ||= Password.new(encrypted_password)
  end

  def password=(new_password)
    @password Password.create(encrypted_password)
    self.encrypted_password = @password
  end

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
