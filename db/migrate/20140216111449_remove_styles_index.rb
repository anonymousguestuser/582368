class RemoveStylesIndex < ActiveRecord::Migration
  def change
    remove_reference :styles, index:true
  end
end
