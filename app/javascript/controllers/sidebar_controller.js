import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["sidebarContainer"]

  connect() {
    console.log("Hello, Stimulus from sidebar", this.element)
  }

  show() {
    this.sidebarContainerTarget.hidden = false
  }

  hide() {
    this.sidebarContainerTarget.hidden = true
  }
}
