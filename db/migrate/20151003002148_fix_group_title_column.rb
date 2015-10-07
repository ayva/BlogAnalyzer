class FixGroupTitleColumn < ActiveRecord::Migration
  def change
    rename_column :groups, :CreateGroups, :name
  end
end
