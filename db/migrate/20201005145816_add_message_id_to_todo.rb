class AddMessageIdToTodo < ActiveRecord::Migration[6.0]
  def change
    add_column :todos, :message_id, :uuid, unique: true, null: false
    add_index :todos, :message_id, unique: true
  end
end
