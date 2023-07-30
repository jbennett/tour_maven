import { Controller } from "@hotwired/stimulus"
import { post } from '@rails/request.js'
import Tourguide from "tourguidejs"

export default class extends Controller {
    static values = {
        tourId: Number,
        selector: String,
        userSgid: String,
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
            onStart: this.onStart.bind(this),
            onStep: this.onStep.bind(this),
            onStop: this.onStop.bind(this),
            onComplete: this.onComplete.bind(this),
            actionHandlers: this.actionHandlers(),
        }
        const userConfig = JSON.parse(this.element.innerHTML)
        const config = { ...defaultConfig, ...userConfig }
        console.log(config)

        this.tour = new Tourguide(config)

        console.log("starting tour", config)
        this.tour.start()
    }

    onStart(e) {
        this.sendBeacon("start")
    }

    onStep(step) {
        this.sendBeacon("step", `${step.index}: ${step.title}`)
    }

    onStop(e) {
        this.sendBeacon("stop")
    }

    onComplete(e) {
        this.sendBeacon("complete")
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

    async sendBeacon(action, identifier) {
        console.log("sending tracking beacon", action, identifier)
        const path = "/foo/events"
        const payload = JSON.stringify({
            event: {
                tour_id: this.tourIdValue,
                action: action,
                identifier: identifier,
                user_sgid: this.userSgidValue,
            }
        })

        const response = await post(path, {
            body: payload
        })

        if (!response.ok) {
            console.error("failed")
            debugger
        }
    }
}
