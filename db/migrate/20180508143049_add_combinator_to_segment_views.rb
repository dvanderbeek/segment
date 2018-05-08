class AddCombinatorToSegmentViews < ActiveRecord::Migration[5.2]
  def change
    add_column :segment_views, :combinator, :string, default: "and"
  end
end
