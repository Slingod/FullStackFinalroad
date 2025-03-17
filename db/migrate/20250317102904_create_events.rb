class CreateEvents < ActiveRecord::Migration[8.0]
  def change
    create_table :events do |t|
      t.string :author
      t.string :location
      t.string :picture
      t.integer :duration
      t.decimal :price
      t.date :date

      t.timestamps
    end
  end
end
