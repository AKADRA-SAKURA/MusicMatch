class Tweet < ApplicationRecord
    belongs_to :user
    has_many :likes, dependent: :destroy
    has_many :liked_users, through: :likes, source: :user
    has_many :comments, dependent: :destroy
    has_many :tag_relations, dependent: :destroy
    has_many :tags, through: :tag_relations, dependent: :destroy
    mount_uploader :image, ImageUploader

    def like_user(user_id)
        likes.find_by(user_id: user_id)
    end
end
