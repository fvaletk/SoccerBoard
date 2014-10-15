class UserMailer < ActionMailer::Base
  
  default from: "from@example.com"

  def player_invitation(recipient_email, team_name, team_owner,token)

    @acceptance_url = "http://127.0.0.1:3000/user_teams/new/accept/"+token
    @declining_url = "http://127.0.0.1:3000/user_teams/new/decline/"+token

    @team_name = team_name
    @team_owner = team_owner
    mail(to: recipient_email, subject: 'Be part of Soccer Board')
  end

  def event_invitation(players, team_name, event)
  	
    	@acceptance_url = "http://127.0.0.1:3000/event_participants/create/accept/"+event.token
      @declining_url = "http://127.0.0.1:3000/event_participants/create/decline/"+event.token
      @team_name = team_name
      @event = event

      players_emails = []

      players.each do |p|
        players_emails.push(p.email)
      end

      mail(to: players_emails, subject: @team_name.titleize + ' Event')
  end

  def owner_invitation(player_email,team_name)
    
      @acceptance_url = "http://127.0.0.1:3000/event_participants/create/accept/"+event.token
      @declining_url = "http://127.0.0.1:3000/event_participants/create/decline/"+event.token
      @team_name = team_name
  

      mail(to: player_email, subject: @team_name.titleize + ' Ownership')
  end

end
