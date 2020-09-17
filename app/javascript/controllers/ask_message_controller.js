// Visit The Stimulus Handbook for more details 
// https://stimulusjs.org/handbook/introduction
// 
// This example controller works with specially annotated HTML like:
//
// <div data-controller="chat-message">
// </div>

import { Controller } from "stimulus"
import { currentAskChannel } from "../channels/current_ask_channel"

export default class extends Controller {
  static targets = ['question', 'delete'];

  delete() {
    this.element.remove();
  }

  promote() {
    currentAskChannel.send({content: this.questionTarget.outerHTML})
    this.element.classList.add('current')
    this.deleteTarget.remove();
  }

  complete() {
    currentAskChannel.send({content: ''})
    this.delete()
  }
}
