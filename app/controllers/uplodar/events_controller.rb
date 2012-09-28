require_dependency "uplodar/application_controller"

module Uplodar
  class EventsController < ApplicationController
    load_and_authorize_resource

    def index
      @events = Event.order("created_at DESC").page(params[:page])
      respond_to do |f|
        f.html  {render 'index'}
        f.js    {render 'index'}
      end
    end

    def show
    end
  end
end
