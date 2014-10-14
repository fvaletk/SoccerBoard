class Invitation < ActiveRecord::Base

  belongs_to :user
  belongs_to :team

  validates :user_id, presence: true
  validates :recipient_email, presence: true

  before_create :generate_token

  def generate_token
    self.token = Digest::SHA1.hexdigest([Time.now, rand].join)
  end

  def self.token_exists_and_is_valid?(token)
    record = Invitation.find_by(token: token)
    record != nil && record.valid_invitation == true ? true : false 
  end

end
