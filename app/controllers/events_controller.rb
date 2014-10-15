class EventsController < ApplicationController

	 before_filter :authenticate_user!, :only => [:show, :new, :create, :edit, :update]
	 before_filter :set_event_value, :only => [:edit,:update,:destroy]

	def index
		redirect_to root_path	
	end 

	def show
		@event = Event.find(params[:id])
		@has_expired = @event.date < Time.now ? true : false
	end

	def new
		@event = Event.new
	end

	def create
		event = Event.new(event_params)
		event.user_id = current_user.id
		event.date = event.date.utc - Time.zone_offset("COT")
		team = Team.find(event.team_id)

		if event.save	
			 UserMailer.event_invitation(team.get_players, team.team_name, event).deliver	
		   flash[:success] = "Event Created Successfully"
		   redirect_to team_path(team.id)
		else
		   flash[:danger] = "Error creating the event"
		   redirect_to :action => :new
		end
	end

	def edit
	end

	def update
		if @event.update(event_params)
			 flash[:success] = "Event Updated Successfully"
		   redirect_to team_path(@event.team_id)
		else
			 flash[:danger] = "Error updating the event"
		   redirect_to :action => :edit
		end
	end

	def destroy
			team_id = @event.team_id
			if @event.destroy
				flash[:success] = "Event deleted Successfully"
		  else
		  	flash[:danger] = "Error deleting the event"
			end
			redirect_to team_path(team_id)
	end

	private
		def event_params
			params.require(:event).permit(:team_id,:subject,:date,:description, :latitude, :longitude)
		end

		def set_event_value
			@event = Event.find(params[:id])
		end
end
