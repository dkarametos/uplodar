require_dependency "uplodar/application_controller"

module Uplodar
  class AssignmentsController < ApplicationController
    before_filter :authenticate_user!
    before_filter :get_user

    def index
      if !@user.blank?
        @shares = @user.share_assignments.select('uplodar_shares.id, uplodar_share_assignments.write, uplodar_shares.name').joins(:share)
      elsif !@share.blank?
        @users  = @share.share_assignments.select('users.id, uplodar_share_assignments.write, users.email').joins(:user)
      end
    end

    def show
      @share      = @user.shares.find(params[:id])
      @assignment = @user.share_assignments.where(:share_id => params[:id]).first
    end

    def update
      @assignment = @user.share_assignments.find(params[:id])

      respond_to do |f|
        if @assignment.update_attributes(params[:share_assignment])
          f.html { redirect_to user_shares_url(@user), :notice => 'Share assignment was successfully updated.' }
        else
          f.html { render :action => "show" }
        end
      end
    end

    def assignments
    end

    def assign
      respond_to do |f|
        if @user.update_attributes(params[:user])
          f.html { redirect_to user_shares_url(@user), :notice =>  'User was successfully updated.' }
        else
          f.html { render :action => "assignments" }
        end
      end
    end

    private
    def get_user
      @user  = Uplodar.user_class.find(params[:user_id])  unless params[:user_id].blank?
      @share = Share.find(params[:share_id])              unless params[:share_id].blank?
    end

  end
end
