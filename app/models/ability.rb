class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    can :manage, :all if user.admin

    parts_permissions(user)
  end

protected

  def parts_permissions(user)
    can :read, Part
  end
end
