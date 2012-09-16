require 'cancan'

module Uplodar
  class ApplicationController < ActionController::Base



    def current_ability
      Uplodar::Ability.new(forem_user)
    end

    rescue_from CanCan::AccessDenied do
      redirect_to root_url, :alert => exception.message
    end
  end
end
