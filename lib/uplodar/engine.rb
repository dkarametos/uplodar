module Uplodar
  class Engine < ::Rails::Engine
    isolate_namespace Uplodar

    class << self
      attr_accessor :root
      def root
        @root ||= Pathname.new(File.expand_path('../../', __FILE__))
      end
    end

    config.to_prepare do
      if Uplodar.user_class
        Uplodar.user_class.send :include, Uplodar::DefaultPermissions

        #Uplodar.user_class.has_many :forem_posts,  :class_name => "Uplodar::Post",   :foreign_key => "user_id"
        #Uplodar.user_class.has_many :forem_topics, :class_name => "Uplodar::Topic",           :foreign_key => "user_id"

        Uplodar.user_class.has_many :share_assignments, :class_name => "Uplodar::ShareAssignment", :foreign_key => "user_id"
        Uplodar.user_class.has_many :shares, :through => :share_assignments, :class_name => "Uplodar::Share", :source => :share

        Uplodar.user_class.has_many :events, :class_name => "Uplodar::Event"
      end
    end
  end
end
require 'simple_form'
require 'kaminari'
require 'jquery-fileupload-rails'
require 'twitter-bootstrap-rails'
require 'jquery-datatables-rails'
