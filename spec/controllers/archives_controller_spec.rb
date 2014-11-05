require 'rails_helper'

describe ArchivesController do
  describe '#index' do
    it 'shows the newest post first' do
      allow(Post).to receive(:sorted).and_return(Post)
      allow(Post).to receive(:published)

      get :index

      expect(Post).to have_received(:sorted)
      expect(Post).to have_received(:published)
    end
  end
end
