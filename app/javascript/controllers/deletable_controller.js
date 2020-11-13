// Visit The Stimulus Handbook for more details 
// https://stimulusjs.org/handbook/introduction
// 
// This example controller works with specially annotated HTML like:
//
// <div data-controller="chat-message">
// </div>

import { Controller } from "stimulus"

export default class extends Controller {
  connect() {
    let timeout = 120_000;
    if (this.data.has('timeout')) {
      timeout = parseInt(this.data.get("timeout")) * 1000;
    }
    setTimeout(() => {
      this.element.remove();
    }, timeout);
  }
}
