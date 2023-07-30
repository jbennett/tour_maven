import { Controller } from "@hotwired/stimulus"
import Tourguide from "tourguidejs"

export default class extends Controller {
    static values = {
        id: Number,
        selector: String,
    }

    connect() {
        if (!this.passesContentSelector()) {
            this.element.remove()
        }
    }

    disconnect() {
        // kill tour
    }

    startTour() {
        const defaultConfig = {
            steps: [],
            onComplete: this.onComplete.bind(this),
            onStop: this.onStop.bind(this),
            actionHandlers: this.actionHandlers(),
        }
        const userConfig = JSON.parse(this.element.innerHTML)
        const config = { ...defaultConfig, ...userConfig }
        console.log(config)

        this.tour = new Tourguide(config)

        console.log("starting tour", config)
        this.tour.start()
    }

    onComplete(e) {
        console.log("compelte", e)
    }

    onStop(e) {
        // Cookies.remove('tourguide_continue')
        // Cookies.remove('tourguide_next_step')

        console.log("stop", e)
    }

    actionHandlers() {
        return [
            new Tourguide.ActionHandler('continueTour', (event, action, context) => {
                event.preventDefault()
                // Cookies.set('tourguide_continue', 'x')
                // Cookies.set('tourguide_next_step', context.currentstep.index + 1)

                window.location = action.href
            })
        ]
    }

    // private

    passesContentSelector() {
        return !this.hasSelectorValue || document.querySelector(this.selectorValue) != null
    }
}
