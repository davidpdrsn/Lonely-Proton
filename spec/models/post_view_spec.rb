# == Schema Information
#
# Table name: post_views
#
#  id         :integer          not null, primary key
#  post_id    :integer
#  created_at :datetime
#  updated_at :datetime
#

require "rails_helper"

describe PostView do
  it { should belong_to :post }
end
