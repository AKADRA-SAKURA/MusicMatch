class TagRelation < ApplicationRecord
  belongs_to :tweet, optional: true
  belongs_to :tag, optional: true


end
