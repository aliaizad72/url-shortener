import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="urlclipboard"
export default class extends Controller {
  static targets = ["link", "notify"]

  copy() {
    console.log("clicked")
    const url = this.linkTarget.textContent
    navigator.clipboard.writeText(url)
    this.notifyTarget.classList.remove("hidden")
    setTimeout(() => {
      this.notifyTarget.classList.add("hidden")
    }, 2000)
  }
}
