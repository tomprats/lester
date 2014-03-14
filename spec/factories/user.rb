require "bcrypt"

FactoryGirl.define do
  factory :user do
    first_name            "Tom"
    last_name             "Prats"
    encrypted_password    BCrypt::Password.create("password")
    sequence(:email)      { |n| "user-#{n}@example#{n}.com" }
  end
end
