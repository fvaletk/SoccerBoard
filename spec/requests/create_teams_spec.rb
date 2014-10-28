require 'rails_helper'

RSpec.describe "CreateTeams", :type => :request do
  describe "GET /create_teams" do
    it "works! (now write some real specs)" do
      patch create_teams_index_path(params)
      expect(response).to have_http_status(200)
    end
  end
end
