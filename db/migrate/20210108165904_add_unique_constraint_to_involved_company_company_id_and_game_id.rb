class AddUniqueConstraintToInvolvedCompanyCompanyIdAndGameId < ActiveRecord::Migration[6.0]
  def change
    add_index :involved_companies, %i[company_id game_id], unique: true
  end
end
