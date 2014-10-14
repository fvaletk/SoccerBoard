class TeamsController < ApplicationController

  before_filter :authenticate_user!, :only => [:new, :create, :edit, :update]
  before_filter :set_team, :only => [:edit, :update]

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
