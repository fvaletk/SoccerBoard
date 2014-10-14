class EventParticipantsController < ApplicationController
	
	before_filter :authenticate_user!, :only => [:new, :create]

	def new
	end

	def create
		event_participant = EventParticipant.new
		if Event.is_token_valid?(params[:event_token])
			event = Event.find_by(token: params[:event_token])
			if event.date > Time.now
				if Team.user_belongs_to_team?(current_user.id,event.team_id)
					event_participant.user_id = current_user.id
					event_participant.event_id = event.id
					if  params[:decision] == "accept"
						event_participant.status = "accepeted"
						message = "Successfully signed in the "+event.subject+ " event"
					else
						event_participant.status = "declined"
						message = "You rejected your participation in the "+event.subject+ " event"
					end 
					if event_participant.save 
						flash[:success] = message
					else
						flash[:danger] = "Could not sign into the event"  				
					end
				else
					flash[:danger] = "You are not authorized to participate in this event"
				end
			else
				flash[:danger] = "This event has expired"
			end
		else
			flash[:danger] = "Token is not valid"
		end
		redirect_to root_path
	end

	private
		def event_participant_params
			params.require(:event_participant).permit(:user_id, :team_id,:status)
		end

end
