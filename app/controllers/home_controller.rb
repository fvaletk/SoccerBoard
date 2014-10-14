class HomeController < ApplicationController
  
  before_filter :validates_user_teams, :only => :index

  def index
  end

  def validates_user_teams
      if current_user && !current_user.have_teams? && !current_user.play_on_teams?
        redirect_to new_team_url
      end
  end

end
