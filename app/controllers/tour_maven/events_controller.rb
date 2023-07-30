module TourMaven
  class EventsController < ApplicationController
    def create
      @event = TourMaven::Event.new(event_params)
      @event.save!

      head :ok
    end

    private

    def event_params
      params.require(:event).permit(:tour_id, :action, :identifer, :user_sgid)
    end
  end
end