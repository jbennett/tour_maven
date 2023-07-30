import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
    connect() {
        alert("from hello controller")
    }
}
