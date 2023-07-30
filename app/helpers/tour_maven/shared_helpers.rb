module TourMaven
  module SharedHelpers
    def tours_controller(tour_selector: '.tour_outlet')
    DEFAULT_TOUR_OUTLET_CLASS = "tour_outlet"
    def tours_controller(tour_class: DEFAULT_TOUR_OUTLET_CLASS)
      tour_selector = ".#{tour_class}" # the outlet uses a selector not the class directly
      tag.template nil, data: { controller: 'tours', tours_tour_outlet: tour_selector}
    end

    def tour_controller(id, user: nil, tour_class: DEFAULT_TOUR_OUTLET_CLASS)
      tour = TourMaven::Tour.find(id)

      tag.template tour.configuration, data: { controller: 'tour', tour_id_value: id }, class: tour_class
    end
  end
end