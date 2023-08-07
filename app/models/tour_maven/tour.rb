module TourMaven
  class Tour < ApplicationRecord

    enum auto_start: { once: "once" }

    scope :in_path, ->(path) {
      where("page_filter IS NULL OR page_filter = ?", path)
    }

    def page_filter=(value)
      super(value.presence)
    end

    def content_selector=(value)
      super(value.presence)
    end
  end
end
