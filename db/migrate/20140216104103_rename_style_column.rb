class RenameStyleColumn < ActiveRecord::Migration
  def change
    rename_column :beers, :style, :old_style
    add_reference :styles, index:true
  end
end
