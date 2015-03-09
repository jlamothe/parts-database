class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    can :manage, :all if user.admin

    user_permissions(user)
    parts_permissions(user)
  end

protected

  def user_permissions(user)
    can [:read, :update], User, { id: user.id }
  end

  def parts_permissions(user)
    can :read, Part
  end
end
