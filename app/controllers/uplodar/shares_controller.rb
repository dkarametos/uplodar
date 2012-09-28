require_dependency "uplodar/application_controller"

module Uplodar
  class SharesController < ApplicationController
    load_and_authorize_resource

    def index
    end

    def show
    end

    def new
    end
    def edit
    end

    def create
      respond_to do |format|
        if @share.save
          format.html { redirect_to @share, :notice => 'Share was successfully created.' }
        else
          format.html { render :action => "new" }
        end
      end
    end

    def update
      respond_to do |format|
        if @share.update_attributes(params[:share])
          format.html { redirect_to @share, :notice =>  'Share was successfully updated.' }
        else
          format.html { render :action => "edit" }
        end
      end
    end

    def destroy
      @share.destroy

      respond_to do |format|
        format.html { redirect_to shares_url }
      end
    end
  end
end
