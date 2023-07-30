module TourMaven
  module SharedHelpers
    DEFAULT_TOUR_OUTLET_CLASS = "tour_outlet"

    def available_tour_controllers(tour_class: DEFAULT_TOUR_OUTLET_CLASS)
      path = request.path
      tours = TourMaven::Tour.in_path(path)

      tours.each do |tour|
        concat tour_controller(tour.id, tour_class: tour_class)
      end
    end

    def tours_controller(tour_class: DEFAULT_TOUR_OUTLET_CLASS)
      tour_selector = ".#{tour_class}" # the outlet uses a selector not the class directly
      tag.template nil, data: { controller: 'tours', tours_tour_outlet: tour_selector}
    end

    def tour_controller(id, user: nil, tour_class: DEFAULT_TOUR_OUTLET_CLASS)
      tour = TourMaven::Tour.find(id)

      tag.template tour.configuration, class: tour_class, data: {
        controller: 'tour',
        tour_id_value: id,
        tour_selector_value: tour.content_selector.presence
      }
    end
  end
end