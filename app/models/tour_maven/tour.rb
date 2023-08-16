module TourMaven
  class Tour < ApplicationRecord
    has_many :events

    enum auto_start: { once: "once", always: "always" }

    scope :available_at, ->(at) do
      where(publish_at: [...at])
        .where("tour_maven_tours.expire_at IS NULL OR tour_maven_tours.expire_at >= ?", at)
    end

    scope :available_for_user, ->(user) do
      merge(start_always.or(start_once(user)))
    end

    scope :start_always, -> { where(auto_start: :always) }
    scope :start_once, ->(user) { where("(tour_maven_tours.auto_start = 'once' AND NOT EXISTS (:start_events))", start_events: TourMaven::Event.select("1").where("tour_maven_tours.id = tour_maven_events.tour_id").where(user: user, action: "start")) }

    scope :in_path, ->(path) do
      where("page_filter IS NULL OR page_filter = ?", path)
    end

    def page_filter=(value)
      super(value.presence)
    end

    def content_selector=(value)
      super(value.presence)
    end

    def configuration=(value)
      super(JSON.parse(value))
    end
  end
end
