class TransferOwnership < ActiveRecord::Base

  belongs_to :user
  belongs_to :team

  validates :user_id, presence: true
  validates :team_id, presence: true

  before_create :generate_token

  def generate_token
    self.token = Digest::SHA1.hexdigest([Time.now, rand].join)
  end

end
