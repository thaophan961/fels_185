class AddIsBlockToCategory < ActiveRecord::Migration
  def change
    add_column :categories, :is_block, :boolean, default: false
  end
end
