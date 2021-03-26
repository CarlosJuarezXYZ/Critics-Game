class InvolvedCompany < ApplicationRecord
  belongs_to :company
  belongs_to :game

  validates :developer, :publisher, inclusion: { in: [false, true] }
  validates :company_id, uniqueness: { scope: :game_id }
end
