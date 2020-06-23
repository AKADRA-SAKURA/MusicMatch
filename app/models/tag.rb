class Tag < ApplicationRecord
    has_many :tag_relations, dependent: :destroy
    has_many :tweet, through: :tag_relations, dependent: :destroy
end
