class AddDraftToPost < ActiveRecord::Migration
  def change
    add_column :posts, :draft, :boolean
  end
end
