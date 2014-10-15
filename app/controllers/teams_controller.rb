class TeamsController < ApplicationController

  before_filter :authenticate_user!, :only => [:new, :create, :edit, :update]
  before_filter :set_team, :only => [:edit, :update, :destroy]

  def index
    redirect_to root_path
  end

  def show
    @team = Team.find(params[:id])
  end

  def new
    @team = Team.new
    @user_team = UserTeam.new
  end

  def create
    team = Team.new(team_params)
    team[:user_id] = current_user.id
    if team.save
      user_team = UserTeam.new(user_team_params)
      user_team.user_id = current_user.id
      user_team.team_id = team.id
      if user_team.save
          flash[:success] = "Team created Successfully"
          redirect_to root_path
      else
        flash[:danger] = user_team.errors.full_messages.to_sentence
        render 'new'
      end  
    else
      flash[:danger] = team.errors.full_messages.to_sentence
      render 'new'
    end
  end

  def edit
  end

  def update
    if @team.update(team_params)
        flash[:success] = "Team updated Successfully"
        redirect_to team_path(@team.id)
    else
        flash[:danger] = team.errors.full_messages.to_sentence
        redirect_to :action=> 'edit', :id => @team.id
    end
  end

  def destroy
     if @team.destroy
       flash[:success] = "Team deleted Successfully"
       redirect_to root_path
     else
       flash[:danger] = "Error deleting the Team"
       redirect_to team_path(@team) 
     end
  end

  def transfer_team_ownership    
  end

  def send_possible_owner_invitation
    UserMailer.player_invitation(invitation.recipient_email, Team.find(invitation.team_id).team_name, owner, invitation.token).deliver 
  end

  def update_team_ownership
    player_id = params[:player_id]
    team_id = params[:team_id]

    if Team.user_belongs_to_team?(player_id,team_id)
      team = Team.find(team_id)
      if team.update(user_id: player.id)
        flash[:success] = "Congratulations your are new owner of Team "+team.team_name
      else
        flash[:danger] = "Error transfering ownership"
      end
    else
      flash[:danger] = "You don't belong to Team "+team.team_name
    end
      redirect_to root_path
  end

  private 
    def team_params
      params.require(:team).permit(:team_name)
    end

    def user_team_params
      params.require(:user_team).permit(:t_shirt_number, :nickname)
    end

    def set_team
        @team = Team.find(params[:id])      
    end
end
