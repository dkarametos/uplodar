require_dependency "uplodar/application_controller"

module Uplodar
  class UsersController < ApplicationController
    before_filter :authenticate_user!

    def index
      @users = Uplodar.user_class.all
    end
  end
end
