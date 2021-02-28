class AddCustomCssToUser < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :custom_css, :string
  end
end
