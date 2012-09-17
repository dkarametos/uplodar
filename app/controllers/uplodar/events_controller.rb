require_dependency "uplodar/application_controller"

module Uplodar
  class EventsController < ApplicationController

    def index
      @events = Event.order("created_at DESC").page(params[:page])
      respond_to do |f|
        f.html  {render 'index'}
        f.js    {render 'index'}
      end
    end

    def show
      @event = Event.find(params[:id])
    end

    def destroy
      @event.destroy

      respond_to do |format|
        format.html { redirect_to events_url }
      end
    end
  end
end
