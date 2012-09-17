require 'uplodar/engine'
require 'uplodar/default_permissions'

module Uplodar
  mattr_accessor :user_class, :display_user_name

  class << self
    def user_class
      if @@user_class.is_a?(Class)
        raise "--user-class-problem--"
      elsif @@user_class.is_a?(String)
        @@user_class.constantize
      end
    end

    def display_user_name
      if @@display_user_name.is_a?(String)
        @@display_user_name
      end
    end
  end
end
