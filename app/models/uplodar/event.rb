module Uplodar
  class Event < ActiveRecord::Base
    paginates_per 5

    belongs_to :user, :class_name => Uplodar.user_class.to_s
    belongs_to :share

    attr_accessible :msg, :action, :share_id, :user_id

    before_validation :cached_fields

    private

    def cached_fields
      self.username = self.user.send Uplodar.display_user_name
      self.sharename = self.share.name
    end
  end
end
