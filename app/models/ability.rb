class Ability
  include CanCan::Ability

  def initialize(user)
    @user = user || User.new

    can :manage, :all if @user.admin
    can :read, :all

    user_permissions
  end

protected

  def user_permissions
    cannot :read, User unless @user.admin
    can [:read, :update, :delete], User, { id: @user.id } if @user.persisted?
  end
end
