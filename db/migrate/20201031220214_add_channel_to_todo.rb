# frozen_string_literal: true

class AddChannelToTodo < ActiveRecord::Migration[6.0]
  def change
    add_column :todos, :channel, :string
  end
end
