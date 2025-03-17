class AddDetailsToUsers < ActiveRecord::Migration[8.0]
  def change
    add_column :users, :username, :string
    add_column :users, :name, :string
    add_column :users, :firstname, :string
    add_column :users, :age, :integer
  end
end
