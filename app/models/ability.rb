# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    if user.is? :admin
      can :delete, Post
    else
      can :delete, Post, author_id: user.id
    end
  end
end
