class AddStyleReferenceToBeer < ActiveRecord::Migration
  def change
    add_column :beers, :style, :integer
  end
end
