class CreateTodoLists < ActiveRecord::Migration
  def self.up
    create_table :todo_lists do |t|
      t.string :name
      t.integer :user_id
      t.boolean :is_private, :default => 0

      t.timestamps
    end
  end

  def self.down
    drop_table :todo_lists
  end
end
