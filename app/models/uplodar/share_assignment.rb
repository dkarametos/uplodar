module Uplodar
  class ShareAssignment < ActiveRecord::Base
    attr_accessible :user_id, :share_id, :write

    belongs_to :user
    belongs_to :share

    after_save    :save_cached_shares
    after_destroy :save_cached_shares

    private
    def save_cached_shares
      user = self.user
      user.cached_shares = user.shares.map{|r| r.name.downcase}.join(', ')
      user.save
    end
  end
end
