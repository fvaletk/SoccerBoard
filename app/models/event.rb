class Event < ActiveRecord::Base

	belongs_to :user
	belongs_to :team
	has_many :event_participants

	validates :user_id, presence: true
	validates :team_id, presence: true
	validates :subject, presence: true
	validates :description, presence: true
	validates :date, presence: true

	before_create :generate_token

	def generate_token
   		self.token = Digest::SHA1.hexdigest([Time.now, rand].join)
  	end
	
	def self.is_token_valid?(token)
		Event.find_by(token: token) != nil ? true : false
	end

	def have_participants?
		self.event_participants != nil ? true : false
	end

	def user_already_registered?(user_id)
		self.event_participants.where(user_id: user_id) != nil ? true : false 
	end

end
