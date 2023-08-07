module TourMaven
  class Tour < ApplicationRecord
    has_many :events

    enum auto_start: { once: "once" }

    scope :in_path, ->(path) {
      where("page_filter IS NULL OR page_filter = ?", path)
    }

    def self.available_for_user(user)
      left_joins(:events)
        .where("NOT EXISTS (:start_events)",
               start_events: TourMaven::Event.select("1").where("tour_maven_tours.id = tour_maven_events.tour_id").where(user: user, action: "start")
               ) # Once
    end

    def page_filter=(value)
      super(value.presence)
    end

    def content_selector=(value)
      super(value.presence)
    end
  end
end
