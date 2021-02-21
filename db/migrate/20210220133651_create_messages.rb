class CreateMessages < ActiveRecord::Migration[6.1]
  def change
    create_table :messages, id: :uuid do |t|
      t.string :channel
      t.integer :kind, null: false, default: 0
      t.integer :status, null: false, default: 0
      t.string :from_username
      t.string :content

      t.timestamps
    end
  end
end
