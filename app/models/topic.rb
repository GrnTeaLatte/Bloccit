class Topic < ActiveRecord::Base
  has_many :posts, as: :commentable, dependent: :destroy
  has_many :labelings, as: :labelable
  has_many :labels, through: :labelings
  has_many :comments, as: :commentable, dependent: :destroy
end
