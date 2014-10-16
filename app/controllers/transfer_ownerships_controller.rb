class TransferOwnershipsController < ApplicationController

  def index
    redirect_to root_path
  end

  def new
    redirect_to root_path
  end

  def create
      transfer_ownership = TransferOwnership.new
      transfer_ownership.user_id = params[:user_id]
      transfer_ownership.team_id = params[:team_id]
      if transfer_ownership.save
          UserMailer.owner_invitation(User.find(transfer_ownership.user_id).email,Team.find(transfer_ownership.team_id).team_name, transfer_ownership.token).deliver
          flash[:success] = "Your Request for transfering the team's ownership was sent"
      else
          flash[:danger] = "Error sending your request for transfering the team's ownership"
      end
      redirect_to team_path(transfer_ownership.team_id)
  end

  def edit
    redirect_to root_path
  end

  def update
      if TransferOwnership.find_by(token: params[:token]) != nil
         transfer_ownership = TransferOwnership.find_by(token: params[:token])
         team = Team.find(transfer_ownership.team_id)
         old_owner = User.find(team.user_id)
         player = User.find(transfer_ownership.user_id)

         if params[:decision] == "accept"
            transfer_ownership.update(status: "accept")
            team.update(user_id: transfer_ownership.user_id) 
            message = "Ownership transfered Successfully"
         else
            transfer_ownership.update(status: "decline")
            message = "Ownership rejected Successfully"
         end

         UserMailer.old_owner_notification(old_owner,player,team,transfer_ownership).deliver
         flash[:success] = message
         sign_in_and_redirect(player)
      else
        flash[:danger] = "The transfer token is not valid"
        redirect_to root_path
      end

      
  end

end
