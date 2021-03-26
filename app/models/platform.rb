class Platform < ApplicationRecord
  has_and_belongs_to_many :games

  validates :name, presence: true, uniqueness: true
  validates :category, presence: true
end
