class Taggable < ActiveRecord::Base
  belongs_to :tagged, polymorphic: true
  belongs_to :tag
end
