class RemovePictureFromEvents < ActiveRecord::Migration[8.0]
  def change
    remove_column :events, :picture, :string
  end
end
