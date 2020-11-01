// Visit The Stimulus Handbook for more details 
// https://stimulusjs.org/handbook/introduction
// 
// This example controller works with specially annotated HTML like:
//
// <div data-controller="chat-message">
// </div>

import { Controller } from "stimulus"
import { buildCurrentAskChannel } from "../channels/current_ask_channel"

export default class extends Controller {
  static targets = ['question', 'delete'];

  connect() {
    this.currentAskChannel = buildCurrentAskChannel(this.data.get('channel'));
  }

  delete() {
    this.element.remove();
  }

  promote() {
    this.currentAskChannel.send({
      channel: this.data.get('channel'),
      content: this.questionTarget.outerHTML
    });
    this.element.classList.add('current');
    this.deleteTarget.remove();
  }

  complete() {
    this.currentAskChannel.send({ 
      channel: this.data.get('channel'),
      content: '' });
    this.delete();
  }
}
