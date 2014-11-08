require "rails_helper"

describe AdminController do
  describe "#index" do
    it "does not let people through without authenticating" do
      get :index
      expect(response.status).to eq 401
    end

    it "does let people through with authenticating" do
      http_login
      get :index
      expect(response.status).to eq 200
    end
  end
end
