class GuestsController < ApplicationController


  def index
    redirect_to root_path
  end

  def new
      @user = User.new
      @user_team = UserTeam.new

      if Invitation.token_exists_and_is_valid?(params[:invitation_token])
        @@invitation = Invitation.find_by :token => params[:invitation_token]
        if params[:decision] == "decline"
          @@invitation.update(:valid_invitation => false)
          flash[:success] = "Invitation Rejected"
          redirect_to root_path
        end
      else
        flash[:danger] = "Invitation is not valid or has expired"
        redirect_to root_path
      end
  end

  def create
      user = User.new(user_params)
      user_team = UserTeam.new(user_team_params)
      user.email = @@invitation.recipient_email
      if user_team.t_shirt_number != nil && user_team.nickname != nil
          if user.save 
          user_team.team_id = @@invitation.team_id
          user_team.user_id = user.id
            if user_team.save
                flash[:success] = "Registration successfully"
                sign_in_and_redirect(user)
            else
              flash[:danger] = "Registration failed"
              redirect_to :action => :new, :decision => "accept", :invitation_token => @@invitation.token
            end
          else
              flash[:danger] = "Registration failed"
              redirect_to :action => :new, :decision => "accept",:invitation_token => @@invitation.token
          end
      else
          flash[:danger] = "Registration failed"
          redirect_to :action => :new, :decision => "accept", :invitation_token => @@invitation.token
      end  
  end

  private
    def user_params
      params.require(:user).permit(:first_name, :last_name, :password, :password_confirmation)
    end

    def user_team_params
      params.require(:user_team).permit(:t_shirt_number, :nickname, :team_id)
    end

end
