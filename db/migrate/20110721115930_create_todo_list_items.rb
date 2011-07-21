class CreateTodoListItems < ActiveRecord::Migration
  def self.up
    create_table :todo_list_items do |t|
      t.string :text
      t.integer :todo_list_id

      t.timestamps
    end
  end

  def self.down
    drop_table :todo_list_items
  end
end
