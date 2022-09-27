import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="toggle-occurence-button"
export default class extends Controller {
  static targets = [ "button", "span" ]
  static classes = [ "buttonDisabled", "buttonEnabled", "spanDisabled", "spanEnabled" ]
  connect() {
  }

  toggle() {
    this.buttonTarget.classList.toggle(this.buttonDisabledClass)
    this.buttonTarget.classList.toggle(this.buttonEnabledClass)
    this.spanTarget.classList.toggle(this.spanDisabledClass)
    this.spanTarget.classList.toggle(this.spanEnabledClass)
  }
}
