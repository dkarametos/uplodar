require 'rails/generators'
module Uplodar
  module Generators
    class InstallGenerator < Rails::Generators::Base
      class_option "no-migrate", :type => :boolean

      source_root File.expand_path("../install/templates", __FILE__)
      desc "Used to install Uplodar"

      def install_migrations
        puts "Copying over Uplodar migrations..."
        Dir.chdir(Rails.root) do
          `rake uplodar:install:migrations`
        end
      end


      def add_uplodar_initializer
        path = "#{Rails.root}/config/initializers/uplodar.rb"
        if File.exists?(path)
          puts "Skipping config/initializers/uplodar.rb creation, as file already exists!"
        else
          puts "Adding uplodar initializer (config/initializers/uplodar.rb)..."
          template "initializer.rb", path
        end
      end

      def run_migrations
        unless options["no-migrate"]
          puts "Running rake db:migrate"
          `rake db:migrate`
        end
      end

      def seed_database
        load "#{Rails.root}/config/initializers/uplodar.rb"
        unless options["no-migrate"]
          puts "Creating default forum and topic"
          Uplodar::Engine.load_seed
        end
      end

      def mount_engine
        unless options["just-migrate"]
          puts "Mounting Uplodar::Engine at \"/uplodar\" in config/routes.rb..."
          insert_into_file("#{Rails.root}/config/routes.rb", :after => /routes.draw.do\n/) do
            %Q{  mount Uplodar::Engine => "/uplodar"\n}
          end
        end
      end

      def run_bootstrap_initializer
        unless options["just-migrate"]
          puts "Installing twitter bootstrap"
          Rails::Generators.invoke "bootstrap:install", [], :behavior => :invoke, :destination_root => Rails.root
        end
      end

      def run_simple_form_initializer
        unless options["just-migrate"]
          puts "Installing simple_form with bootstrap support"
          Rails::Generators.invoke "simple_form:install", ["--bootstrap"], :behavior => :invoke, :destination_root => Rails.root
        end
      end

      def finished
        output = "\n\n" + ("*" * 53) + "\n"
        output += step("A new file was created at config/initializers/uplodar.rb This is where you put Uplodar's configuration settings.\n")

        unless options["no-migrate"]
          output += step("`rake db:migrate` was run, running all the migrations against your database.\n")
        end

        unless options["just-migrate"]
          output += step("The engine was mounted in your config/routes.rb file using this line:\n")
          output += "  mount Uplodar::Engine, :at => \"/uplodar\" \n"
          output += "If you want to change where the forums are located, just change the \"/forums\" path at the end of this line to whatever you want."
          output += "\nAnd finally:\n"
          output += "#{step("We told you that Uplodar has been successfully installed and walked you through the steps.")}"
        end

        unless defined?(Devise)
          output += "We have detected you're not using Devise (which is OK with us, really!), so there's one extra step you'll need to do.\n
                     You'll need to define a \"sign_in_path\" method for Uplodar to use that points to the sign in path for your application.\n"
        end

        output += "\nIf you have any questions, comments or issues, please post them on our issues page: http://github.com/dkarametos/uplodar/issues.\n\n"
        output += "Thanks for using Uplodar!"
        puts output
      end

      private

      def step(words)
        @step ||= 0
        @step += 1
        "#{@step}) #{words}\n"
      end

      def user_class
        @user_class
      end

      def next_migration_number
        last_migration = Dir[Rails.root + "db/migrate/*.rb"].sort.last.split("/").last
        current_migration_number = /^(\d+)_/.match(last_migration)[1]
        current_migration_number.to_i + 1
      end
    end
  end
end
