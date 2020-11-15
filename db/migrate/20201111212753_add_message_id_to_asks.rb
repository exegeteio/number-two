# frozen_string_literal: true

class AddMessageIdToAsks < ActiveRecord::Migration[6.0]
  def change
    add_column :asks, :message_id, :uuid, unique: true, null: false
    add_index :asks, :message_id, unique: true
  end
end
