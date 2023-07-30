module TourMaven
  class Event < ApplicationRecord
    belongs_to :user, polymorphic: true
    belongs_to :tour

    def action=(value)
      super(value.presence)
    end

    def identifer=(value)
      super(value.presence)
    end

    def user_sgid=(sgid)
      self.user = GlobalID::Locator.locate_signed(sgid)
    end
  end
end
