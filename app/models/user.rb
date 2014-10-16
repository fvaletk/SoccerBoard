class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable

  has_many :user_teams
  has_many :teams, through: :user_teams
  has_many :invitations
  has_many :event_participants
  has_many :transfer_ownerships

  TEMP_EMAIL_PREFIX = 'change@me'
  TEMP_EMAIL_REGEX = /\Achange@me/

  validates :first_name, presence: true
  validates :last_name, presence: true

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable, :omniauth_providers => [:facebook, :twitter]


  validates_format_of :email, :without => TEMP_EMAIL_REGEX, on: :update

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

  def self.find_for_oauth(auth, signed_in_resource = nil)

    identity = Identity.find_for_oauth(auth)
    user = signed_in_resource ? signed_in_resource : identity.user

    if user.nil?

      email_is_verified = auth.info.email && (auth.info.verified || auth.info.verified_email)
      email = auth.info.email if email_is_verified
      user = User.where(:email => email).first if email

      if user.nil?
        if auth.provider == "facebook"
          first_name = auth.info.first_name != nil ? auth.info.first_name : "none"
          last_name = auth.info.last_name != nil ? auth.info.last_name : "none"

        elsif auth.provider == "twitter"
          
          temp = auth.info.name.split(" ")
          first_name = temp[0] != nil ? temp[0] : "none"
          last_name = temp[1] != nil ? temp[1] : "none"
        end

        user = User.new(
          first_name: first_name,
          last_name: last_name,
          #username: auth.info.nickname || auth.uid,
          email: email ? email : "#{TEMP_EMAIL_PREFIX}-#{auth.uid}-#{auth.provider}.com",
          password: Devise.friendly_token[0,20]
        )
        #user.skip_confirmation!
        user.save!
      end
    end

    # Associate the identity with the user if needed
    if identity.user != user
      identity.user = user
      identity.save!
    end
    user
  end

  def email_verified?
    self.email && self.email !~ TEMP_EMAIL_REGEX
  end
  
end
