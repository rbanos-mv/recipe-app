class Ability
  include CanCan::Ability

  def initialize(user)
    return unless user.present?

    can :destroy, Recipe, user:
  end
end
