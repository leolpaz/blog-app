# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    can :read, Post
    return unless user.present?
    can :manage, Post, author_id: user.id || user.role: "admin"
    can :create, Comment
    can :manage, Comment, author_id: user.id || user.role: "admin"
  end
end
