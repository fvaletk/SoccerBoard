class TeamsController < ApplicationController

  before_filter :authenticate_user!, :only => [:new, :create, :edit, :update]
  before_filter :set_team, :only => [:show, :edit, :update, :destroy]

  def index
    redirect_to root_path
  end

  def show
  end

  def new
    @team = Team.new
    @team.user_teams.build
  end

  def create
    team = Team.new(team_nested_params)
    if team.save
      flash[:success] = "Team created Successfully"
      redirect_to root_path 
    else
      flash[:danger] = team.errors.full_messages.to_sentence
      redirect_to :action=>'new'
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

  private 
    def team_nested_params
      @team_attributes = params.require(:team).permit(:team_name, user_teams_attributes: [:t_shirt_number, :nickname])

      @team_attributes[:user_id] = current_user.id
      @team_attributes[:user_teams_attributes]["0"][:user_id] = current_user.id
      @team_attributes
    end

    def team_params
      params.require(:team).permit(:team_name, user_teams_attributes: [:t_shirt_number, :nickname])
    end

    def set_team
      @team = Team.find(params[:id])
    end
end
