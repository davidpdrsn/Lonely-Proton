class CreatePostViews < ActiveRecord::Migration
  def change
    create_table :post_views do |t|
      t.references :post
      t.timestamps
    end
  end
end
