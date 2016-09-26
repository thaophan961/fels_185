class CreateRelationships < ActiveRecord::Migration
  def change
    create_table :relationships do |t|
      t.integer :followed
      t.integer :follower

      t.timestamps null: false
    end
    add_index :relationships, :follower
    add_index :relationships, :followed
    add_index :relationships, [:follower, :followed], unique: true
  end
end
