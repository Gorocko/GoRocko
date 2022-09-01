import { Controller } from "@hotwired/stimulus"
import TomSelect from "tom-select"
import { get } from '@rails/request.js'

// Connects to data-controller="ts--select"
export default class extends Controller {
  static values = { url: String }
  connect() {
  new TomSelect(this.element, {
      plugins: ['remove_button'],
      create: true,
        valueField: 'name',
        labelField: 'name',
        searchField: 'name',
      load: (q, callback) => this.search(q, callback),
        render: {
          option: function(item, escape) {
            return `<div class="py-2 d-flex">
							<div>
								<div class="mb-1">
									<span class="h4">
										${ escape(item.name) }
									</span>
								</div>
							</div>
						</div>`;
          },
          item: function(item, escape) {
            return `<div class="py-2 d-flex">
							<div>
								<div class="mb-1">
									<span class="h4">
										${ escape(item.name) }
									</span>
								</div>
							</div>
						</div>`;
          }
        },
    }
    )
  }

  async search(q, callback) {
    const response = await get(this.urlValue, {
      query: { q: q },
      responseKind: 'json'
    })

    if (response.ok) {
      const list = await response.json
      callback(list)
    } else {
      console.log(response)
      callback()
    }
  }
}
