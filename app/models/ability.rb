class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    if user.is? :admin
      can :destroy, Post
      can :destroy, Comment
    else
      can :destroy, Post, author_id: user.id
      can :create, Comment
      can :destroy, Comment, user_id: user.id
    end
  end
end
