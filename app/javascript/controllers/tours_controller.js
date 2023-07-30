import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
    static outlets = ["tour"]

    connect() {
        this.tourOutlets[0]?.startTour()
    }
}
