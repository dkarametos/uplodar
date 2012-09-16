module Uplodar
  module DefaultPermissions
    extend ActiveSupport::Concern

    included do
      unless method_defined?(:is_admin?)
        def is_admin?
          true
        end
      end
      unless method_defined?(:can_browse_with_uplodar?)
        def can_browse_with_uplodar?
          true
        end
      end

      unless
        method_defined?(:can_create_folders_with_uplodar?)
        def can_create_folders_with_uplodar?
          true
        end
      end

      unless
        method_defined?(:can_upload_file_with_uplodar?)
        def can_upload_file_with_uplodar?
          true
        end
      end

      unless
        method_defined?(:can_move_file_with_uplodar?)
        def can_move_file_with_uplodar?
          true
        end
      end

      unless
        method_defined?(:can_delete_file_with_uplodar?)
        def can_delete_file_with_uplodar?
          true
        end
      end

      unless
        method_defined?(:can_admin_uplodar_shares?)
        def can_admin_uplodar_shares?
          true
        end
      end

      unless
        method_defined?(:can_read_uplodar_logs?)
        def can_read_uplodar_logs?
          true
        end
      end
    end
  end
end
