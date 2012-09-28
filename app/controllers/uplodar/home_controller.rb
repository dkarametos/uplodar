require_dependency "uplodar/application_controller"

module Uplodar
  class HomeController < ApplicationController
    before_filter :authenticate_user!

    def index
      @shares = current_user.is_uplodar_admin? ? Share.all : current_user.shares
      #redirect_to browser_url(:share => @shares.first.name) if @shares.length == 1
    end

    private
    def check_or_login
      redirect_to main_app.new_user_session_url unless current_user
    end
  end
end
