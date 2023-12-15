class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    if user.is? :admin
      can :delete, Post
      can :delete, Comment
    else
      can :delete, Post, author_id: user.id
      can :delete, Comment, user_id: user.id
    end
  end
end
