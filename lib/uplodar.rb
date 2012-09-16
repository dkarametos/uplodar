require 'uplodar/engine'
require 'uplodar/default_permissions'

module Uplodar
  mattr_accessor :user_class

  class << self
    def user_class
      if @@user_class.is_a?(Class)
        raise "--user-class-problem--"
      elsif @@user_class.is_a?(String)
        @@user_class.constantize
      end
    end
  end
end
