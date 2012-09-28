module Uplodar
  module DefaultPermissions
    extend ActiveSupport::Concern
    included do
      unless method_defined?(:is_uplodar_admin?)
        def is_uplodar_admin?
          return uplodar_admin if self.respond_to? :uplodar_admin
          return true if self.id == 1
          false
        end
      end

      unless method_defined?(:is_uplodar_shares_admin?)
        def is_uplodar_shares_admin?
          false
        end
      end

      unless
        method_defined?(:is_uplodar_shares_editor?)
        def is_uplodar_shares_editor?(share)
          !!self.cached_shares.include?(share)
        end
      end

      unless
        method_defined?(:is_uplodar_shares_reader?)
        def is_uplodar_shares_reader?(share)
          !!self.cached_shares.include?(share)
        end
      end
    end
  end
end
