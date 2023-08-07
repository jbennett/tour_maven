class CreateTourMavenTours < ActiveRecord::Migration[7.0]
  def change
    create_table :tour_maven_tours do |t|
      t.string :label, null: false

      if t.respond_to?(:jsonb)
        t.jsonb :configuration, null: false, default: {}
      else
        t.json :configuration, null: false, default: {}
      end

      t.timestamps
    end
  end
end
