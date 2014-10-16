class UserTeamsController < ApplicationController

  before_filter :set_user_team, :only => [:edit,:update]

  def index
    redirect_to root_path
  end

  def show
    redirect_to root_path
  end

  def new
    @user_team = UserTeam.new
    if Invitation.token_exists_and_is_valid?(params[:invitation_token])
      @invitation = Invitation.find_by(token: params[:invitation_token])
      if params[:decision] == "decline"
        @invitation.update(:valid_invitation => false, :status => "declined")
        flash[:success] = "Invitation Rejected"
        redirect_to root_path
      else
        if !User.user_already_exists?(@invitation.recipient_email)
          @user = User.new
        end
      end
    else
      flash[:danger] = "Invitation is not valid or has expired"
      redirect_to root_path
    end
  end

  def create
    user_team = UserTeam.new(user_team_params)
    invitation = Invitation.find(invitation_param[:id])
    

    if User.find_by(email: invitation.recipient_email) != nil
      user = User.find_by(email: invitation.recipient_email)
    else
      user = User.new(user_params)
      user.email = invitation.recipient_email
      if user_team.t_shirt_number != nil && user_team.nickname != nil
        if !user.save
         return_to_new
        end
      else
        return_to_new
      end
    end
    if user.id != nil
      user_team.user_id = user.id
      user_team.team_id = invitation.team_id
      invitation.update(:valid_invitation => false, :status => "accepted")
      if user_team.save
        flash[:success] = "Player Created Successfully"
        sign_in_and_redirect(user)
      else
        return_to_new 
      end
    end
  end

  def edit
  end

  def update
    if @user_team.update(user_team_params)
      flash[:success] = "Profile Updated Successfully"
      redirect_to team_path(@user_team.team_id)
    else
      flash[:danger] = "Couldn't update player profile"
      redirect_to :action => :edit
    end
  end

 

  private
    def user_team_params
      params.require(:user_team).permit(:nickname, :t_shirt_number)
    end

    def user_params
      params.require(:user).permit(:first_name, :last_name,:password,:password_confirmation)
    end

    def invitation_param
      params.require(:invitation).permit(:id)
    end

    def return_to_new
        flash[:danger] = "Error Registering Player"
        redirect_to :action => :new, :decision => "accept", :invitation_token => invitation.token
    end

    def set_user_team
       @user_team = UserTeam.find(params[:id])
    end

end
