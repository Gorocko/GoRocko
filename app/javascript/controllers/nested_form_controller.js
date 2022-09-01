import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="nested-form"
export default class extends Controller {
  static targets = [ "button", "template", "formList"]
  connect() {
    this.wrapperClass = this.data.get("wrapperClass") || "nested-fields"
  }
  add_association(event) {
    var content = this.templateTarget.innerHTML.replace(/NEW_RECORD/g, new Date().getTime())
    this.formListTargets[this.formListTargets.length - 1].insertAdjacentHTML('afterend', content)
  }
  remove_association(event) {

    let wrapper = event.currentTarget.closest("li")
    let nested_form_wrapper = event.currentTarget.closest("." + this.wrapperClass)
    if (nested_form_wrapper.dataset.newRecord == "true") {
      wrapper.remove()

      // Existing records are hidden and flagged for deletion
    } else {
      nested_form_wrapper.querySelector("input[name*='_destroy']").value = 1
      wrapper.style.display = 'none'
    }
  }
}
