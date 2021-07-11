class FixColmnName < ActiveRecord::Migration[5.1]
  def change
    rename_column :micro_posts, :context, :content
  end
end
