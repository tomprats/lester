FactoryGirl.define do
  factory :gallery do
    association :artist, factory: :user
    title                 "Masterpiece"
    description           "Who wouldn't love her?"
  end
end
