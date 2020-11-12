class CreateAsks < ActiveRecord::Migration[6.0]
  def change
    create_table :asks do |t|
      t.string :user_name
      t.string :user_color
      t.string :message
      t.string :channel
      t.integer :status, default: 0

      t.timestamps
    end
    add_index :asks, :channel
  end
end
