class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable

  has_many :user_teams
  has_many :teams, through: :user_teams
  has_many :invitations
  has_many :event_participants

  validates :first_name, presence: true
  validates :last_name, presence: true

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  def have_teams?
     self.teams.where(user_id: self.id).count > 0 ? true : false
  end

  def play_on_teams?
    self.teams.where.not(user_id: self.id).count > 0 ? true : false
  end

  def get_teams
    self.teams
  end

  def get_play_teams
    self.teams.where.not(user_id: self.id)
  end

  def get_info(user_id, team_id,at)
    user_team = UserTeam.find_by user_id: user_id, team_id: team_id
    if user_team != nil
      if at == "nickname"
        user_team.nickname 
      elsif at == "t_shirt_number"
        user_team.t_shirt_number
      end
    else
      return ""
    end 
  end

  def owner_team?(team_id)
      self.id == Team.find(team_id).user_id ? true : false
  end

  def self.full_name(user_id)
      User.find(user_id).first_name + " "+User.find(user_id).last_name
  end

  def self.user_already_exists?(email)
     user = User.find_by email: email
     user != nil ? true : false 
  end

  def self.have_invitations?(user_email)
    Invitation.all.where(recipient_email: user_email, valid_invitation: true).count > 0 ? true : false
  end

  def self.get_invitations(user_email)
    Invitation.all.where(recipient_email: user_email, valid_invitation: true)
  end

  def get_sent_invitations
    self.invitations.where(valid_invitation: false)
  end
  
end
