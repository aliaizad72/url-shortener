import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="notice"
export default class extends Controller {
  static targets = ["reason"]
  connect() {
  }

  reveal() {
    this.reasonTarget.classList.remove("text-darkslategrey")
    this.reasonTarget.classList.add("text-vanilla")
    setTimeout(() => {
      this.reasonTarget.classList.remove("text-vanilla")
      this.reasonTarget.classList.add("text-darkslategrey")
    }, 5000)
  }
}
