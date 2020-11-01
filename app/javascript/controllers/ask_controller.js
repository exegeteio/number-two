// Visit The Stimulus Handbook for more details 
// https://stimulusjs.org/handbook/introduction
// 
// This example controller works with specially annotated HTML like:
//
// <div data-controller="ask">
//   <h1 data-target="ask.output"></h1>
// </div>

import { Controller } from "stimulus"
import { buildAskMessagesChannel } from "../channels/ask_messages_channel"

export default class extends Controller {
  static targets = ['questions']

  connect() {
    let askMessagesChannel = buildAskMessagesChannel()
    askMessagesChannel.received = (data) => {
      this.questionsTarget.insertAdjacentHTML('beforeend', data)
    }
  }
}
