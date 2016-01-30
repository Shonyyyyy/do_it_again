class CreateNodes < ActiveRecord::Migration
  def change
    create_table :nodes do |t|
      t.string :title
      t.text :content
      t.references :annoyer, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
