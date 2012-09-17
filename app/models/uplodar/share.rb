module Uplodar
  class Share < ActiveRecord::Base
    has_many  :share_assignments
    has_many  :users, :through => :share_assignments, :class_name => Uplodar.user_class.to_s

    attr_accessible :name, :path, :url

    validates :name, :presence => true, :uniqueness => true
    validates :path, :presence => true, :uniqueness => true
    validates :url,  :presence => true, :uniqueness => true

  end
end
