class Team < ActiveRecord::Base

  has_many :user_teams, dependent: :destroy
  has_many :users, through: :user_teams
  has_many :invitations, dependent: :destroy
  has_many :events, dependent: :destroy
  has_many :transfer_ownerships, dependent: :destroy

  validates :team_name, presence: true

  def get_owners_name(user_id)
      name = User.find(user_id).first_name+" "+User.find(user_id).last_name
  end

  def is_owner?(user_id)
      user_id == self.user_id ? true : false
  end

  def have_players?
    self.users.where.not(id: self.user_id).count > 0 ? true : false
  end

  def get_players
      self.users.where.not(id: self.user_id)
  end

  def get_player_id(user_id)
    user_team = UserTeam.find_by user_id: user_id, team_id: self.id
    user_team != nil ? user_team.id : ""
  end

  def self.get_team_name(team_id)
      Team.find(team_id).team_name
  end

  def have_events?
      self.events.count > 0 ? true : false
  end

  def self.user_belongs_to_team?(user_id, team_id)
    Team.find(team_id).users.where(id: user_id) != nil ? true : false
  end
end
