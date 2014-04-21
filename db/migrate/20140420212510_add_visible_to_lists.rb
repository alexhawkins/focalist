class AddVisibleToLists < ActiveRecord::Migration
  def change
    add_column :lists, :visible, :boolean, default: true
  end
end
