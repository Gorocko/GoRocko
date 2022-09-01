import { Controller } from "@hotwired/stimulus"
import  {FetchRequest} from '@rails/request.js'

// Connects to data-controller="batch-edit-form"

function convertFormToHash (formData) {
  let object = {};
  formData.forEach((value, key) => {
    if (!Reflect.has(object, key)) {
      object[key] = value;
      return;
    }
    if (!Array.isArray(object[key])) {
      object[key] = [object[key]];
    }
    object[key].push(value);
  });
  return object
}

export default class extends Controller {
  static values = { url: String }
  static targets = [ "actionEventForm" ]
  connect() {
    console.log("this is test")
  }

  async submitForms(event) {
    event.preventDefault();
    let url = event.currentTarget.dataset.batchEditFormUrlValue
    let redirectUrl = event.currentTarget.dataset.batchEditFormRedirectUrlValue
    let formDataList = this.actionEventFormTargets.map((fromTarget) => new FormData(fromTarget))
    let formHashes = {'action_event_collection': []}
    formDataList.forEach((element, index) => formHashes['action_event_collection'].push(convertFormToHash(element)))

    const request = new FetchRequest("post", url, {body: JSON.stringify(formHashes)})
    const response = await request.perform()
    if (response.ok){
      window.location.replace(redirectUrl )
    }else{
      console.log("something went wrong")
    }
  }




}
