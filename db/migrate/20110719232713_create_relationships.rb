class CreateRelationships < ActiveRecord::Migration
  def self.up
    create_table :relationships do |t|
      t.integer :follower_id
      t.integer :todo_list_id

      t.timestamps
    end

    add_index :relationships, :follower_id
    add_index :relationships, :todo_list_id

  end

  def self.down
    drop_table :relationships
  end
end
