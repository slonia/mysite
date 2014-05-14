class Ability
  include CanCan::Ability

  def initialize(user)
    if user.is_a?(Admin)
      can :manage, :all
    else
      cannot :manage, :all
      can :read, [Group]
    end
  end
end
