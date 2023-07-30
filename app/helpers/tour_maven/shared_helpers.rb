module TourMaven
  module SharedHelpers
    def tours_controller(tour_selector: '.tour_outlet')
      tag.template nil, data: { controller: 'tours', tours_tour_outlet: tour_selector}
    end

    def tour_controller(id, user: nil, tour_class: 'tour_outlet')
      tour = TourMaven::Tour.find(id)

      tag.template tour.configuration, data: { controller: 'tour', tour_id_value: id }, class: tour_class
    end
  end
end