import { Controller } from "@hotwired/stimulus"
import { useTransition, useClickOutside } from 'stimulus-use'
// Connects to data-controller="flash"
export default class extends Controller {
  static targets = ['flash_message']
  connect() {
    this.element.style.animation = "fade-in-and-out 3s"
    setTimeout(() => {this.leave()}, 3000)
    useTransition(this, {
      element: this.flashMessageTarget,
      enterActive: 'transform ease-out duration-300 transition',
      enterFrom: 'translate-y-2 opacity-0 sm:translate-y-0 sm:translate-x-2',
      enterTo: 'translate-y-0 opacity-100 sm:translate-x-0',
      leaveActive: 'transition ease-in duration-100',
      leaveFrom: 'opacity-100',
      leaveTo: 'opacity-0',
      // set this, because the item *starts* in an open state
      transitioned: true,
    });
    // useClickOutside(this, { element: this.flashMessageTarget})
  }

  close(event) {
    this.leave();
  }

  // clickOutside(event) {
  //   event.preventDefault()
  //   this.close()
  // }

}
