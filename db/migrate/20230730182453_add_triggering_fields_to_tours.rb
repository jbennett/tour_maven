class AddTriggeringFieldsToTours < ActiveRecord::Migration[7.0]
  def change
    add_column :tour_maven_tours, :page_filter, :string, null: true
    add_column :tour_maven_tours, :content_selector, :string, null: true
  end
end
