require 'rails_helper'

RSpec.describe Team, :type => :model do

  it "is valid with a team_name and user.id" do
    expect(create(:team)).to be_valid   
  end

  it "is invalid without a team_name " do
    team = build(:team,team_name: nil)
    team.valid?
    expect(team.errors[:team_name]).to include("can't be blank")  
  end

  it "is invalid without a user.id" do
    team = build(:team, user_id: nil)
    team.valid?
    expect(team.errors[:user_id]).to include("can't be blank")  
  end

  it "is has a user_team association" do
    expect(create(:team).user_teams.count).to eq 1
  end

  it "has an unique team name" do
    team = create(:team,team_name: "Barcelona")
    another_team = build(:team, team_name: "Barcelona")
    another_team.valid?
    expect(another_team.errors[:team_name]).to include("has already been taken")
  end
end