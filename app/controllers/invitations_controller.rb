class InvitationsController < ApplicationController

  before_filter :authenticate_user!, :only => [:new, :create]  

  def index
    redirect_to root_path
  end

  def new
    @invitation = Invitation.new
  end

  def create
    invitation = Invitation.new(invitation_params)
    invitation.user_id = current_user.id
    owner = current_user.first_name+" "+current_user.last_name

    if invitation.save
       UserMailer.player_invitation(invitation.recipient_email, Team.find(invitation.team_id).team_name, owner, invitation.token).deliver
       flash[:success] = "Your invitation was sent successfully"
       redirect_to root_path
    else
       flash[:danger] = "Invitation was not saved"
       render 'new'
    end
  end

  private
    def invitation_params
        params.require(:invitation).permit(:recipient_email, :team_id)
    end

end
