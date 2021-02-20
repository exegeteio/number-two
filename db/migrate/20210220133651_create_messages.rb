class CreateMessages < ActiveRecord::Migration[6.1]
  def change
    create_table :messages do |t|
      t.string :channel
      t.integer :kind
      t.integer :status
      t.string :from_username
      t.string :content

      t.timestamps
    end
  end
end
