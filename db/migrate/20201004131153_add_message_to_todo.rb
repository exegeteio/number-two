class AddMessageToTodo < ActiveRecord::Migration[6.0]
  def change
    add_column :todos, :message, :string
  end
end
