// Visit The Stimulus Handbook for more details 
// https://stimulusjs.org/handbook/introduction
// 
// This example controller works with specially annotated HTML like:
//
// <div data-controller="chat-message">
// </div>

import { Controller } from "stimulus"

export default class extends Controller {
  static targets = ['deletable']

  connect() {
    setTimeout(() => {
      this.element.classList.add('fade');
    }, 50_000);
    setTimeout(() => {
      this.element.remove();
    }, 60_000);
  }
}
