class CreateAnnoyers < ActiveRecord::Migration
  def change
    create_table :annoyers do |t|
      t.string :title
      t.string :color
      t.timestamps null: false
    end
  end
end
