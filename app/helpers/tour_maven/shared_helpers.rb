module TourMaven
  module SharedHelpers
    DEFAULT_TOUR_OUTLET_CLASS = "tour_outlet"

    def available_tour_controllers(user: nil, tour_class: DEFAULT_TOUR_OUTLET_CLASS)
      path = request.path
      tours = TourMaven::Tour.in_path(path)
      tours = tours.available_for_user(user) if user

      capture do
        tours.each do |tour|
          concat tour_controller(tour.id, user: user, tour_class: tour_class)
        end
      end
    end

    def tour_button(label, tour, user: nil, **btn_options)
      tag.div data: {
        controller: 'tour',
        tour_tour_id_value: tour.id,
        tour_user_sgid_value: user&.to_sgid.to_s,
        tour_event_path_value: TourMaven::Engine.routes.url_helpers.events_path,
      } do
        concat tag.button(label, "data-action": "tour#startTour", **btn_options)
        concat tag.template(tour.configuration, "data-tour-target": "configuration")
      end
    end

    def tours_controller(tour_class: DEFAULT_TOUR_OUTLET_CLASS)
      tour_selector = ".#{tour_class}" # the outlet uses a selector not the class directly
      tag.template nil, data: {
        controller: 'tours',
        tours_tour_outlet: tour_selector,
      }
    end

    def tour_controller(id, user: nil, tour_class: DEFAULT_TOUR_OUTLET_CLASS)
      tour = TourMaven::Tour.find(id)

      tag.template tour.configuration, class: tour_class, data: {
        controller: 'tour',
        tour_tour_id_value: id,
        tour_selector_value: tour.content_selector.presence,
        tour_user_sgid_value: user&.to_sgid.to_s,
        tour_event_path_value: TourMaven::Engine.routes.url_helpers.events_path,
      }
    end

  end
end