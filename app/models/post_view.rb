# == Schema Information
#
# Table name: post_views
#
#  id         :integer          not null, primary key
#  post_id    :integer
#  created_at :datetime
#  updated_at :datetime
#

class PostView < ActiveRecord::Base
  belongs_to :post, counter_cache: true
end
