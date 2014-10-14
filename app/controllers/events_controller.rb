class EventsController < ApplicationController

	 before_filter :authenticate_user!, :only => [:show, :new, :create, :edit, :update]

	def index
		redirect_to root_path	
	end 

	def show
		@event = Event.find(params[:id])
		@has_expired = @event.date < Time.now ? true : false
	end

	def new
		@event = Event.new
		@team_id = params[:team_id]
		@@global_team = Team.find(@team_id)
		if !current_user.have_teams?
			flash[:danger] = "You don't have teams"
			redirect_to root_path
		end
	end

	def create
		event = Event.new(event_params)
		event.user_id = current_user.id
		event.team_id = @@global_team.id
		event.date = event.date.utc - Time.zone_offset("COT")

		if event.save	
			 UserMailer.event_invitation(@@global_team.get_players, @@global_team.team_name, event).deliver	
		   flash[:success] = "Event Created Successfully"
		   redirect_to team_path(@@global_team.id)
		else
		   flash[:danger] = "Error creating the event"
		   redirect_to :action => :new, :team_id => @@global_team.id
		end

	end

	private
		def event_params
			params.require(:event).permit(:team_id,:subject,:date,:description, :latitude, :longitude)
		end

end
