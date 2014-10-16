class UserMailer < ActionMailer::Base
  
  default from: "from@example.com"
  @url = "ktraining.herokuapp.com"


  def player_invitation(recipient_email, team_name, team_owner,token)
    #ktraining.herokuapp.com

    @acceptance_url = "http://#{@url}/user_teams/new/accept/"+token
    @declining_url = "http://#{@url}/user_teams/new/decline/"+token

    @team_name = team_name
    @team_owner = team_owner
    mail(to: recipient_email, subject: 'Be part of Soccer Board')
  end

  def event_invitation(players, team_name, event)
  	
    	@acceptance_url = "http://#{@url}/event_participants/create/accept/"+event.token
      @declining_url = "http://#{@url}/event_participants/create/decline/"+event.token

      @team_name = team_name
      @event = event

      players_emails = []

      players.each do |p|
        players_emails.push(p.email)
      end

      mail(to: players_emails, subject: @team_name.titleize + ' Event')
  end

  def owner_invitation(player_email,team_name,token)
    
      @acceptance_url = "http://#{@url}/transfer_ownerships/update/accept/"+token
      @declining_url = "http://#{@url}/transfer_ownerships/update/decline/"+token

      @team_name = team_name
  

      mail(to: player_email, subject: @team_name.titleize + ' Ownership')
  end

  def old_owner_notification(old_owner, player, team, team_ownership)
      
      @old_owner_name = User.full_name(old_owner.id)
      @player_name = User.full_name(player.id)
      @team_name = team.team_name
      if team_ownership.status == "accept"
         @decision = "accepted"
      else
         @decision = "declined"
      end
  
      mail(to: old_owner.email, subject: @team_name.titleize + ' Transfer Ownership '+@decision)
  end

end
