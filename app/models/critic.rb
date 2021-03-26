class Critic < ApplicationRecord
  belongs_to :user, counter_cache: :critics_count
  belongs_to :criticable, polymorphic: true

  validates :title, presence: true, length: { maximum: 40 }
  validates :body, presence: true
end
