class AddVisibilityOptionsToUsers < ActiveRecord::Migration[8.0]
  def change
    add_column :users, :show_name, :boolean
    add_column :users, :show_firstname, :boolean
    add_column :users, :show_email, :boolean
    add_column :users, :show_age, :boolean
  end
end
