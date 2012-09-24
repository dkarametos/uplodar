class AddCachedShares < ActiveRecord::Migration
  def change
    unless column_exists?(user_class, :cached_shares)
      add_column user_class, :cached_shares, :string, :default => ''
    end
  end

  def user_class
    Uplodar.user_class.table_name.downcase.to_sym
  end
end
