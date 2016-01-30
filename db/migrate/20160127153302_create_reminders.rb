class CreateReminders < ActiveRecord::Migration
  def change
    create_table :reminders do |t|
      t.string :title
      t.integer :frequency
      t.string :repeat
      t.references :annoyer, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
