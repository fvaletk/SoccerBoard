Rails.application.routes.draw do
  root 'home#index'

  devise_for :users
  resources :teams
  resources :user_teams, except: :new
  match 'user_teams/new/:decision/:invitation_token', to: 'user_teams#new', via: [:get], as: "new_user_team"
  resources :invitations
  resources :events, except: :new
  match 'events/new/:team_id', to: 'events#new', via: [:get], as: "new_event"
  resources :event_participants, except: :create
  match 'event_participants/create/:decision/:event_token', to: 'event_participants#create', via: [:get], as: "create_event_participant"
end
