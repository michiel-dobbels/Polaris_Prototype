class Entity < ApplicationRecord
  has_one_attached :profile_image
  has_one_attached :cover_photo
  has_many :follows, as: :followable, dependent: :destroy
end
