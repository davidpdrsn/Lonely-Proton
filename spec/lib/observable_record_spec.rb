require "rails_helper"

describe ObservableRecord do
  it "notifies an observer if saving was successful" do
    record = double("post", save: true, persisted?: false)
    observer = double("observer")
    allow(observer).to receive(:saved).with(record)

    worked = ObservableRecord.new(record, observer).save

    expect(worked).to eq true
    expect(observer).to have_received(:saved).with(record)
  end

  it "doesn't notify the observer if saving was not successful" do
    record = double("post", save: false, persisted?: false)
    observer = double("observer")
    allow(observer).to receive(:saved).with(record)

    worked = ObservableRecord.new(record, observer).save

    expect(worked).to eq false
    expect(observer).not_to have_received(:saved).with(record)
  end

  it "notifies an observer if update was successful" do
    record = double("post", update: true, persisted?: true, save: true)
    observer = double("observer")
    allow(observer).to receive(:updated).with(record)

    worked = ObservableRecord.new(record, observer).update(title: "foo")

    expect(worked).to eq true
    expect(observer).to have_received(:updated).with(record)
  end

  it "doesn't notify the observer if update was not successful" do
    record = double("post", update: false, persisted?: true, save: false)
    observer = double("observer")
    allow(observer).to receive(:updated).with(record)

    worked = ObservableRecord.new(record, observer).update(title: "foo")

    expect(worked).to eq false
    expect(observer).not_to have_received(:updated).with(record)
  end
end
