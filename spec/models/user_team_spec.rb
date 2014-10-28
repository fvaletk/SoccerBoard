require 'rails_helper'

RSpec.describe UserTeam, :type => :model do

  it "is valid with a user.id, team.id, t_shirt_number and nickname" do
    expect(create(:user_team)).to be_valid   
  end

  it "is invalid without a user.id " do
    user_team = build(:user_team,user_id: nil)
    user_team.valid?
    expect(user_team.errors[:user_id]).to include("can't be blank")  
  end

  it "is invalid without a team.id" do
    user_team = build(:user_team, team_id: nil)
    user_team.valid?
    expect(user_team.errors[:team_id]).to include("can't be blank")  
  end

  it "is invalid without a t_shirt_number" do
    user_team = build(:user_team, t_shirt_number: nil)
    user_team.valid?
    expect(user_team.errors[:t_shirt_number]).to include("can't be blank")  
  end

  it "is invalid without a nickname" do
    user_team = build(:user_team, nickname: nil)
    user_team.valid?
    expect(user_team.errors[:nickname]).to include("can't be blank")  
  end

end