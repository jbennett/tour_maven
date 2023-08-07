class AddAutoStartToTourMavenTours < ActiveRecord::Migration[7.0]
  def change
    add_column :tour_maven_tours, :auto_start, :string, null: false, default: :once
  end
end
