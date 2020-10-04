class CreateTodos < ActiveRecord::Migration[6.0]
  def change
    create_table :todos do |t|
      t.string :username
      t.boolean :current, default: false
      t.boolean :completed, default: false
      t.boolean :deleted, default: false

      t.timestamps
    end
  end
end
