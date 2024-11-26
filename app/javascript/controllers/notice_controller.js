import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="notice"
export default class extends Controller {
  static targets = ["reason"]
  connect() {
    console.log("connnect")
  }

  reveal() {
    this.reasonTarget.classList.remove("text-darkslategrey")
    this.reasonTarget.classList.add("text-vanilla")
  }

  hide() {
    this.reasonTarget.classList.remove("text-vanilla")
    this.reasonTarget.classList.add("text-darkslategrey")
  }
}
