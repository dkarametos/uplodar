require_dependency "uplodar/application_controller"

module Uplodar
  class SharesController < ApplicationController
    def index
      @shares = Share.all
    end

    def show
      @share = Share.find(params[:id])
    end

    def new
      @share = Share.new
    end
    def edit
      @share = Share.find(params[:id])
    end

    def create
      @share = Share.new(params[:share])

      respond_to do |format|
        if @share.save
          format.html { redirect_to @share, :notice => 'Share was successfully created.' }
        else
          format.html { render :action => "new" }
        end
      end
    end

    def update
      @share = Share.find(params[:id])

      respond_to do |format|
        if @share.update_attributes(params[:share])
          format.html { redirect_to @share, :notice =>  'Share was successfully updated.' }
        else
          format.html { render :action => "edit" }
        end
      end
    end

    def destroy
      @share = Share.find(params[:id])
      @share.destroy

      respond_to do |format|
        format.html { redirect_to shares_url }
      end
    end
  end
end
