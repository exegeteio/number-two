// Visit The Stimulus Handbook for more details 
// https://stimulusjs.org/handbook/introduction
// 
// This example controller works with specially annotated HTML like:
//
// <div data-controller="current-ask">
// </div>

import { Controller } from "stimulus"
import { buildCurrentAskChannel } from "../channels/current_ask_channel"

export default class extends Controller {
  static targets = ['question']

  connect() {
    let currentAskChannel = buildCurrentAskChannel(this.data.get('channel'));
    currentAskChannel.received = (data) => {
      this.questionTarget.innerHTML = data['content']
    }
  }
}
