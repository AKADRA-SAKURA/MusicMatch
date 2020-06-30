class Tag < ApplicationRecord
    has_many :tag_relations, dependent: :destroy
    has_many :tweet, through: :tag_relations, dependent: :destroy

    scope :from_tag, -> (tweet_id)  { where(id: tweet_ids = TweetTag.where(tag_id: tag_id).select(:tweet_id))}
end
