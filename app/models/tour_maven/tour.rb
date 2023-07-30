module TourMaven
  class Tour < ApplicationRecord

    scope :in_path, ->(path) {
      where('page_filter IS NULL or page_filter = ?', path)
    }
  end
end
