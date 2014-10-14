class UserTeam < ActiveRecord::Base

  belongs_to :user
  belongs_to :team

  validates :user_id, presence: true
  validates :team_id, presence: true 
  validates :t_shirt_number, presence: true
  validates :nickname, presence: true


end
