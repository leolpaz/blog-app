class Ability
  include CanCan::Ability

  def initialize(user)
    can :read, Post
    return unless user.present?

    can :manage, Post, user_id: user.id
    can :create, Comment
    can :manage, Comment, user_id: user.id
    return unless user.admin?

    can :manage, :all
  end
end
