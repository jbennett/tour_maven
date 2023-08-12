class AddPublishingToTourMavenTours < ActiveRecord::Migration[7.0]
  def change
    add_column :tour_maven_tours, :publish_at, :datetime, null: true
    add_column :tour_maven_tours, :expire_at, :datetime, null: true
  end
end
