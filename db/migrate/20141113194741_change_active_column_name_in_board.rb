class ChangeActiveColumnNameInBoard < ActiveRecord::Migration
  def change
    rename_column :boards, :active, :is_active
  end
end
