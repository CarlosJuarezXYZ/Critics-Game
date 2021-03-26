class Game < ApplicationRecord
  enum category: { expansion: 1, main_game: 0 }

  has_one_attached :cover
  has_and_belongs_to_many :platforms
  has_and_belongs_to_many :genres
  has_many :companies, through: :involved_companies
  has_many :involved_companies, dependent: :destroy
  has_many :critics, as: :criticable, dependent: :destroy
  has_many :expansions, class_name: 'Game', foreign_key: 'parent_id', dependent: :nullify, inverse_of: false
  belongs_to :parent, class_name: 'Game', optional: true

  validates :name, presence: true, uniqueness: true
  validates :category, presence: true
  validates :rating, inclusion: { in: 0..100, message: 'Should be between 0 and 100' }, allow_nil: true

  #OJO
  # validate :parent_validation

  # def parent_validation
  #   if expansion?
  #     errors.add(:parent, 'Should ve a valid Game id') unless Game.exists?(parent.id)
  #   elsif main_game?
  #     errors.add(:parent, 'Should be null if main_game') unless parent.nil?
  #   end
  # end

end
