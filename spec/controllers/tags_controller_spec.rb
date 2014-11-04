require 'rails_helper'

describe TagsController do
  describe "#create" do
    it 'requires authentication' do
      post :create, tag: { name: "foo" }
      expect(response.status).to eq 401
    end

    it 'creates the tag if its valid' do
      http_login

      expect do
        post :create, tag: { name: "foo" }
      end.to change { Tag.count }.by 1

      expect(response.status).to eq 201
    end

    it 'does not create the tag if its invalid' do
      http_login

      expect do
        post :create, tag: { name: nil }
      end.not_to change { Tag.count }

      expect(response.status).to eq 422
    end
  end
end
