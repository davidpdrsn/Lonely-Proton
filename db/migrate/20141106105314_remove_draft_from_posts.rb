class RemoveDraftFromPosts < ActiveRecord::Migration
  def change
    remove_column :posts, :draft
  end
end
