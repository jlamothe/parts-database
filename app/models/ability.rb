class Ability
  include CanCan::Ability

  def initialize(user)
    @user = user || User.new

    can :manage, :all if @user.admin
    can [:index, :show], :all

    user_permissions
  end

protected

  def user_permissions
    cannot [:index, :show], User unless @user.admin
    can [:show, :update, :delete], User, { id: @user.id } if @user.persisted?
  end
end
