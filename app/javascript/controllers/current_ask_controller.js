// Visit The Stimulus Handbook for more details 
// https://stimulusjs.org/handbook/introduction
// 
// This example controller works with specially annotated HTML like:
//
// <div data-controller="current-ask">
// </div>

import { Controller } from "stimulus"
import { currentAskChannel } from "../channels/current_ask_channel"

export default class extends Controller {
  static targets = ['question']

  connect() {
    currentAskChannel.received = (data) => {
      this.questionTarget.innerHTML = data['content']
    }
  }
}
