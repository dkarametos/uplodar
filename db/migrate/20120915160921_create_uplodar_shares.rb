class CreateUplodarShares < ActiveRecord::Migration
  def change
    create_table :uplodar_shares do |t|
      t.string :name
      t.string :path
      t.string :url

      t.timestamps
    end
  end
end
