RSpec::Matchers.define :have_checked_checkbox do
  match do |actual|
    have_css("input[type=checkbox][checked]").matches?(actual)
  end

  failure_message do
    "Expected to find checked checkbox"
  end

  failure_message_when_negated do
    "Expected not to find checked checkbox"
  end

  description do
    "has checked checkbox"
  end
end
