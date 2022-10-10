import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="toggle-occurrence-button"
export default class extends Controller {
  static targets = [ "button", "span", "occurrenceComponent", "recurrentEventField" ]
  static classes = [ "buttonDisabled", "buttonEnabled", "spanDisabled", "spanEnabled" ]
  connect() {
  }

  toggle() {
    this.recurrentEventFieldTarget.value = !(this.recurrentEventFieldTarget.value == 'true')
    this.buttonTarget.classList.toggle(this.buttonDisabledClass)
    this.buttonTarget.classList.toggle(this.buttonEnabledClass)
    this.spanTarget.classList.toggle(this.spanDisabledClass)
    this.spanTarget.classList.toggle(this.spanEnabledClass)
  }
}
