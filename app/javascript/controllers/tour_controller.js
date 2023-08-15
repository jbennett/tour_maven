import { Controller } from "@hotwired/stimulus"
import { post } from '@rails/request.js'
import { TourGuideClient } from "@sjmc11/tourguidejs/src/Tour"

export default class extends Controller {
    static targets = ["configuration"]
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

    setupTour() {
        const defaultConfig = {
            steps: [],
        }
        const userConfig = JSON.parse(this.tourConfig)
        const config = { ...defaultConfig, ...userConfig }

        this.tour = new TourGuideClient(config)
        this.tour.onBeforeStepChange(this.beforeStep.bind(this))
        this.tour.onAfterStepChange(this.afterStep.bind(this))
        this.tour.onBeforeExit(this.onQuit.bind(this))
        this.tour.onFinish(this.onComplete.bind(this))
    }

    startTour() {
        if (!this.tour) {
            this.setupTour()
        } else {
            this.tour.visitStep(0)
        }

        this.tour.start()
        this.sendBeacon("start")
    }

    // private

    beforeStep() {
        this.tryClick(this.currentStep.beforeClick)
    }

    afterStep() {
        const currentStep = this.currentStep
        const identifier = `${this.tour.activeStep}: ${currentStep.title}`
        this.sendBeacon("step", identifier)
        this.tryClick(this.currentStep.afterClick)
    }

    onQuit() {
        if (this.tour.activeStep === this.tour.tourSteps.length - 1) return // don't track quits for complete tours

        this.sendBeacon("quit")
    }

    onComplete() {
        this.sendBeacon("complete")
    }


    passesContentSelector() {
        return !this.hasSelectorValue || document.querySelector(this.selectorValue) != null
    }

    async sendBeacon(action, identifier) {
        if (!this.hasUserSgidValue) {
            console.log("no user")
            return
        }

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

    get tourConfig() {
        if (this.hasConfigurationTarget) {
            return this.configurationTarget.innerHTML
        } else {
            return this.element.innerHTML
        }
    }

    get currentStep() {
        return this.tour.tourSteps[this.tour.activeStep]
    }

    tryClick(selector, bubbles = false) {
        const node = document.querySelector(selector)
        if (!node) return

        let event = new Event("click", {
            bubbles: bubbles
        })
        node.dispatchEvent(event)
    }
}
