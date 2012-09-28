require 'cancan'

class UplodarAbility
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    can :manage, :all do
      user.is_uplodar_admin?
    end

    can :manage, :shares do
      user.is_uplodar_shares_admin?
    end

    can :manage, :events do
      user.is_uplodar_shares_admin?
    end

    can :write, Uplodar::Share do |share|
      user.is_uplodar_shares_editor?(share.name)
    end

    can :read, Uplodar::Share do |share|
      user.is_uplodar_shares_reader?(share.name)
    end
  end
end
