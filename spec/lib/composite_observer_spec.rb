require_relative "../../lib/composite_observer"

describe CompositeObserver do
  it "forwards notifications to several observers" do
    a = double("observer_a")
    allow(a).to receive(:saved)
    allow(a).to receive(:updated)

    b = double("observer_b")
    allow(b).to receive(:saved)
    allow(b).to receive(:updated)

    record = double("record")

    observer = CompositeObserver.new([a, b])
    observer.saved(record)
    observer.updated(record)

    expect(a).to have_received(:saved).with(record)
    expect(a).to have_received(:updated).with(record)
    expect(b).to have_received(:saved).with(record)
    expect(b).to have_received(:updated).with(record)
  end
end
