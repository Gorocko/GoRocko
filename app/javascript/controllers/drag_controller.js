import { Controller } from "@hotwired/stimulus"
import Sortable from "sortablejs";
import  {patch} from '@rails/request.js'
// Connects to data-controller="drag"
export default class extends Controller {
  static values = {
    url: String
  }
  connect() {
    this.sortable = Sortable.create(this.element, {
      group: 'shared',
      animation: 150,
      draggable: ".dog-group",
      dragClass:"dog-group",
      onEnd: this.end.bind(this)
    })
  }
  end(event) {
    let url = event.item.dataset.dragUrlValue
    let data = new FormData()

    data.append("group[position]", event.newIndex + 1)

    patch(url, { body: data, responseKind: 'turbo-stream' })

  }
}
