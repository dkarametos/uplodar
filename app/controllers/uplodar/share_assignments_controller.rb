require_dependency "uplodar/application_controller"

module Uplodar
  class ShareAssignmentsController < ApplicationController
    def index
      @user = Uplodar.user_class.find(params[:permission_id])
      @shares = @user.shares.all
    end

    def show
      @user = Uplodar.user_class.find(params[:permission_id])
      @share = @user.shares.find(params[:id])
    end

    def new
      @share_assignment = ShareAssignment.new
    end

    def edit
      @share_assignment = ShareAssignment.find(params[:id])
    end

    def create
      @share_assignment = ShareAssignment.new(params[:share_assignment])

      respond_to do |f|
        if @share_assignment.save
          f.html { redirect_to @share_assignment, :notice => 'Share assignment was successfully created.' }
        else
          f.html { render :action => "new" }
        end
      end
    end

    def update
      @share_assignment = ShareAssignment.find(params[:id])

      respond_to do |f|
        if @share_assignment.update_attributes(params[:share_assignment])
          f.html { redirect_to @share_assignment, :notice => 'Share assignment was successfully updated.' }
        else
          f.html { render :action => "edit" }
        end
      end
    end

    def destroy
      @share_assignment = ShareAssignment.find(params[:id])
      @share_assignment.destroy

      respond_to do |f|
        f.html { redirect_to share_assignments_url }
      end
    end
  end
end
