class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_many :tweets, dependent: :destroy, optional: true
  has_many :likes, dependent: :destroy, optional: true
  has_many :liked_tweets, through: :likes, source: :tweet
  has_many :comments, dependent: :destroy, optional: true
  mount_uploader :icon_url, ImageUploader
  has_many :tag, optional: true

  def already_liked?(t)
    self.likes.exists?(tweet_id: t.id)
  end

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
