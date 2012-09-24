require_dependency "uplodar/application_controller"

module Uplodar
  class UsersController < ApplicationController
    def index
      @users = Uplodar.user_class.all
    end

    def show
      @user = Uplodar.user_class.find(params[:id])
    end

    def edit
      @user = Uplodar.user_class.find(params[:id])
    end

    def update
      @user = Uplodar.user_class.find(params[:id])

      respond_to do |format|
        if @user.update_attributes(params[:user])
          format.html { redirect_to @user, :notice =>  'User was successfully updated.' }
        else
          format.html { render :action => "edit" }
        end
      end
    end

    def destroy
      @user = Uplodar.user_class.find(params[:id])
      @user.destroy

      respond_to do |format|
        format.html { redirect_to users_url }
      end
    end
  end
end
