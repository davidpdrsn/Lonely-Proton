class AddViewsCountToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :post_views_count, :integer

    Post.reset_column_information
    Post.all.each do |p|
      Post.update_counters(p.id, post_views_count: p.post_views.length)
    end
  end
end
