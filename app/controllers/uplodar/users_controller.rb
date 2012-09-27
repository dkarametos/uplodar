require_dependency "uplodar/application_controller"

module Uplodar
  class UsersController < ApplicationController
    def index
      @users = Uplodar.user_class.all
    end
  end
end
