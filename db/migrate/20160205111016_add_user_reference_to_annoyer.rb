class AddUserReferenceToAnnoyer < ActiveRecord::Migration
  def change
    change_table :annoyers do |t|
      t.references :user, index: true, foreign_key: true
    end
  end
end
