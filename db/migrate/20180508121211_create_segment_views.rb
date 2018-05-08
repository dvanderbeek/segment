class CreateSegmentViews < ActiveRecord::Migration[5.2]
  def change
    create_table :segment_views do |t|
      t.string :title
      t.string :model
      t.string :type

      t.timestamps
    end
  end
end
