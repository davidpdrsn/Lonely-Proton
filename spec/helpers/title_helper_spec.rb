require "rails_helper"

describe TitleHelper do
  it "assigns the @post instance variable" do
    a = ABaseClass.new
    a.title("A title")
    expect(a.instance_variable_get("@title")).to eq "A title"
  end
end

class ABaseClass
  include TitleHelper
end
