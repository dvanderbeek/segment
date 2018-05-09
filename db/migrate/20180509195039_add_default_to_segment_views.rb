class AddDefaultToSegmentViews < ActiveRecord::Migration[5.2]
  def change
    add_column :segment_views, :default, :boolean, default: false
  end
end
