class CreateTourMavenEvents < ActiveRecord::Migration[7.0]
  def change
    create_table :tour_maven_events do |t|
      t.references :user, polymorphic: true, null: false
      t.references :tour, null: false, foreign_key: {to_table: :tour_maven_tours}
      t.string :action, null: false
      t.string :identifier, null: true

      t.timestamps
    end
  end
end
