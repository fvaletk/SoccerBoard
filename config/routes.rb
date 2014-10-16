Rails.application.routes.draw do
  root 'home#index'

  devise_for :users, :controllers => { omniauth_callbacks: 'omniauth_callbacks', :registrations => "registrations" }
  match '/users/:id/finish_signup' => 'users#finish_signup', via: [:get, :patch], :as => :finish_signup
  resources :users
  resources :teams
  resources :user_teams, except: :new
  match 'user_teams/new/:decision/:invitation_token', to: 'user_teams#new', via: [:get], as: "new_user_team"
  resources :invitations
  resources :events
  resources :event_participants, except: :create
  match 'event_participants/create/:decision/:event_token', to: 'event_participants#create', via: [:get], as: "create_event_participant"
  resources :transfer_ownerships, except: [:create,:update] 
  match 'transfer_ownerships/create/:team_id/:user_id', to: 'transfer_ownerships#create', via: [:get], as: "create_transfer_ownership"
  match 'transfer_ownerships/update/:decision/:token', to: 'transfer_ownerships#update', via: [:get], as: "update_transfer_ownership"

end
