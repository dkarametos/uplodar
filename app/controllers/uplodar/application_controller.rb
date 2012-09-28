require 'cancan'

module Uplodar
  class ApplicationController < ActionController::Base



    def current_ability
       @current_ability ||= UplodarAbility.new(current_user)
    end

    rescue_from CanCan::AccessDenied do |e|
      redirect_to root_url, :alert => e.message
    end

    rescue_from ActiveRecord::RecordNotFound do |e|
      redirect_to root_url, :alert => "Page not found"
    end
  end
end
