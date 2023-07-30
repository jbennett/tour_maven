import { Application } from "@hotwired/stimulus"

const application = Application.start()

// Configure Stimulus
application.warnings = true
application.debug = true // false
window.Stimulus = application

export { application }