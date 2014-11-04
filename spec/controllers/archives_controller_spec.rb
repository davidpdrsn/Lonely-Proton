require 'rails_helper'

describe ArchivesController do
  describe '#index' do
    it 'shows the newest post first' do
      allow(Post).to receive(:sorted)
      get :index
      expect(Post).to have_received(:sorted)
    end
  end
end
