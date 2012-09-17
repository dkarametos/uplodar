class CreateUplodarEvents < ActiveRecord::Migration
  def change
    create_table :uplodar_events do |t|
      t.integer :user_id
      t.integer :share_id
      t.string :username
      t.string :sharename
      t.string :action
      t.string :msg

      t.timestamps
    end
  end
end
