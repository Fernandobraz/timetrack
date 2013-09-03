class Ability
  include CanCan::Ability

  def initialize(user)
    if user.nil?
      user = User.new
    end
    
    if user.role == "Super Admin"
       can :manage, :all
    elsif user.role == "Recruitment Company Manager"
      can :manage, [User, Client, Project, Timesheet]
    elsif user.role == "Recruitment Company Administrator"
      can :manage, [User, Client, Project, Timesheet]
    elsif user.role == "Recruitment Company Accountancy"
      can :manage, [User, Client, Project, Timesheet]
    elsif user.role == "Recruitment Company Recruiter"
      # manage products, assets he owns
      can :read, Client.users.include?(user)
    elsif user.role == "Client"
      can :manage, [User, Client, Project, Timesheet]
    elsif user.role == "Authoriser"
      can :manage, [User, Client, Project, Timesheet]
    elsif user.role == "Consultant"
      can :manage, [User, Client, Project, Timesheet]
    end
  end
  
  private
  
    def permission?(permission)
      return !!self.permissions.find_by_name(permission.to_s.camelize)
    end

end
