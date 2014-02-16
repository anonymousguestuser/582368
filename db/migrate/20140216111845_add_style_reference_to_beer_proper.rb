class AddStyleReferenceToBeerProper < ActiveRecord::Migration
  def change
    add_reference :beers, :style, index:true
    remove_column :beers, :style
  end
end
