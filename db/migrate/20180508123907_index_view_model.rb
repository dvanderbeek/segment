class IndexViewModel < ActiveRecord::Migration[5.2]
  def change
    add_index :segment_views, :model
  end
end
