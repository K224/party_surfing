class Ability
  include CanCan::Ability

  def initialize(user)
    can :create, Party unless user.nil?
    can :participate, Party unless user.nil?
    can :comment, Profile unless user.nil?
    can :vote, Profile unless user.nil?
    can :vote, Party unless user.nil?

    user ||= User.new

    can :read, Party
    can :autocomplete_tags, Party
    can :get_parties_in_zone, Party
    can :manage, Party, host_id: user.id unless user.id.nil?
    cannot :participate, Party, host_id: user.id
    can :comment, Party do |party|
      guest = party.guests.find_by(user_id: user.id)
      !guest.nil? && guest.accepted
    end

    can :read, Guest
    can :update, Guest, party: {host_id: user.id}

    can :read, Profile
    can :manage, Profile, user_id: user.id
    # Define abilities for the passed in user here. For example:
    #
    #   user ||= User.new # guest user (not logged in)
    #   if user.admin?
    #     can :manage, :all
    #   else
    #     can :read, :all
    #   end
    # The first argument to `can` is the action you are giving the user 
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on. 
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details:
    # https://github.com/ryanb/cancan/wiki/Defining-Abilities
  end
end
