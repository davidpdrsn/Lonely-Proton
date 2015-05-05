require "rails_helper"

describe PostPersistHook do
  describe "#save" do
    it "raises an exception" do
      expect {
        PostPersistHook.new(post).save
      }.to raise_error("PostPersistHook subclass must implement #save")
    end
  end

  describe "#update" do
    context "with successful safe" do
      it "updates the post" do
        hook = post_persist_hook_subclass.new(post)

        updated = hook.update(params)

        expect(updated).to eq probe
      end

      it "saves" do
        allow(post).to receive(:update).with(params).and_return(true)
        hook = post_persist_hook_subclass.new(post)
        allow(hook).to receive(:save)

        hook.update(params)

        expect(hook).to have_received(:save)
      end
    end

    context "with unsuccessful save" do
      it "doesn't udpate" do
        allow(post).to receive(:update).with(params).and_return(false)
        hook = post_persist_hook_subclass.new(post)
        allow(hook).to receive(:save)

        hook.update(params)

        expect(hook).not_to have_received(:save)
      end
    end

    let(:probe) { double("probe") }
    let(:params) { double("params") }
    let(:post) { stubbed_post }

    def stubbed_post
      post = double("post")
      allow(post).to receive(:update).with(params).and_return(probe)
      post
    end

    def post_persist_hook_subclass
      Class.new(PostPersistHook) do
        def save
        end
      end
    end
  end

  let(:post) { double("post") }
end
