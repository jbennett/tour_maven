import { Controller } from "@hotwired/stimulus"
import { post } from '@rails/request.js'
import { TourGuideClient } from "@sjmc11/tourguidejs/src/Tour"

export default class extends Controller {
    static values = {
        tourId: Number,
        selector: String,
        userSgid: String,
        eventPath: String,
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
            rememberStep: true,
            // actionHandlers: this.actionHandlers(),
        }
        const userConfig = JSON.parse(this.element.innerHTML)
        const config = { ...defaultConfig, ...userConfig }
        console.log(config)

        this.tour = new TourGuideClient(config)
        this.tour.onAfterStepChange(() => {
            this.sendBeacon("step", `${this.tour.activeStep}: ${this.tour.tourSteps[this.tour.activeStep].title}`)
        })
        this.tour.onBeforeExit(() => {
            this.sendBeacon("quit")
        })
        this.tour.onFinish(() => {
            this.sendBeacon("complete")
        })

        console.log("starting tour", config)
        this.tour.start()
        this.sendBeacon("start")
    }

    // actionHandlers() {
    //     return [
    //         new Tourguide.ActionHandler('continueTour', (event, action, context) => {
    //             event.preventDefault()
    //             // Cookies.set('tourguide_continue', 'x')
    //             // Cookies.set('tourguide_next_step', context.currentstep.index + 1)
    //
    //             window.location = action.href
    //         })
    //     ]
    // }

    // private

    passesContentSelector() {
        return !this.hasSelectorValue || document.querySelector(this.selectorValue) != null
    }

    async sendBeacon(action, identifier) {
        console.log("sending tracking beacon", action, identifier)
        const payload = JSON.stringify({
            event: {
                tour_id: this.tourIdValue,
                action: action,
                identifier: identifier,
                user_sgid: this.userSgidValue,
            }
        })

        const response = await post(this.eventPathValue, {
            body: payload
        })

        if (!response.ok) {
            console.error("failed")
            debugger
        }
    }
}
