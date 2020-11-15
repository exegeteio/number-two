# frozen_string_literal: true

class CreateTodos < ActiveRecord::Migration[6.0]
  def change
    create_table :todos do |t|
      t.string :username
      t.string :message
      t.integer :status, default: 0
      t.timestamps
    end
  end
end
