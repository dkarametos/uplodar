class CreateUplodarShareAssignments < ActiveRecord::Migration
  def change
    create_table :uplodar_share_assignments do |t|
      t.integer :user_id
      t.integer :share_id
      t.boolean :write, :default => false
    end
  end
end
