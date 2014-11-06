require 'rails_helper'

describe ArchivesController do
  describe '#index' do
    it 'shows the newest post first' do
      allow(Post).to receive(:recently_published_first)
      get :index
      expect(Post).to have_received(:recently_published_first)
    end
  end
end
