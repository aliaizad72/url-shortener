import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="clipboard"
export default class extends Controller {
  static targets = [ "url", "notice" ]

  copy() {
    const url = this.urlTarget.textContent
    navigator.clipboard.writeText(url)
    this.noticeTarget.textContent = "link copied!"
  }
}
