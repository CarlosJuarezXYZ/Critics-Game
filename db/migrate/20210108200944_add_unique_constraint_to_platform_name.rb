class AddUniqueConstraintToPlatformName < ActiveRecord::Migration[6.0]
  def change
    add_index :platforms, :name, unique: true
  end
end
