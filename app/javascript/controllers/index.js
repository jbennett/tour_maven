import { application } from "./application"

import TourController from "./tour_controller"
application.register("tour", TourController)

import ToursController from "./tours_controller"
application.register("tours", ToursController)