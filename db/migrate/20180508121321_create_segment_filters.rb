class CreateSegmentFilters < ActiveRecord::Migration[5.2]
  def change
    create_table :segment_filters do |t|
      t.belongs_to :view
      t.string :condition
      t.string :value

      t.timestamps
    end

    add_foreign_key :segment_filters, :segment_views, column: :view_id, on_delete: :cascade
  end
end
