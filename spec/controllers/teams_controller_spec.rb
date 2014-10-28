require 'rails_helper'

RSpec.describe TeamsController, :type => :controller do

  let!(:user) {create(:user)}
  
  describe "Methods" do
    context 'when user is logged in' do
      before (:each) do
        sign_in user
      end

      describe "#show" do
        it "assigns the requested team to @team" do
          team = create(:team)
          get :show, id: team
          expect(assigns(:team)).to eq team 
        end

        it "renders the :show template" do
          team = create(:team)
          get :show, id: team
          expect(response).to render_template :show
        end
      end

      describe "#new" do
        it "assigns a new team instance to @team" do
          get :new
          expect(assigns(:team)).to be_a_new(Team)
        end

        it "renders the :new template" do
          get :new
          expect(response).to render_template :new
        end
      end

      describe "#create" do
        before :each do
          @user_team = ["0"=>
            attributes_for(:user_team)
          ]
        end
        it "saves the a new team in the database" do
          expect{
            post :create, team: attributes_for(:team, user_teams_attributes: @user_team)
          }.to change(Team, :count).by(1)
        end

        it "saves the a new user_team in the database" do
          expect{
            post :create, team: attributes_for(:team, user_teams_attributes: @user_team) 
          }.to change(UserTeam, :count).by(1)
        end

        it "redirect to root_path" do
          post :create, team: attributes_for(:team, user_teams_attributes: @user_team)
          expect(response).to redirect_to root_path
        end
      end

      describe "#edit" do
        it "assigns the requested team to @team" do
          team = create(:team)
          get :edit, id: team
          expect(assigns(:team)).to eq team 
        end

        it "renders the :edit template" do
          team = create(:team)
          get :edit, id: team
          expect(response).to render_template :edit
        end
      end

      describe "#update" do
        before :each do
          @team = create(:team, team_name:"Barcelona")
        end
        context 'with valid attributes' do
          it "locates the requested @team" do
            patch :update, id: @team, team: attributes_for(:team)
            expect(assigns(:team)).to eq(@team)
          end
          it "changes team's attributes" do
            patch :update, id: @team, team: attributes_for(:team, team_name: "Real Madrid")
            @team.reload
            expect(@team.team_name).to eq('Real Madrid')
          end
          it "redirects to team_path" do
            patch :update, id: @team, team: attributes_for(:team)
            expect(response).to redirect_to @team
          end
        end
        context 'with invalid attributes' do
          it "does not change the team's attributes" do
            expect{
              patch :update, id: @team, team: attributes_for(:team, team_name: nil)
            }.to raise_error
          end
        end
      end
    end
  end
  
end
