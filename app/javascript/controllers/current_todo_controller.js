// Visit The Stimulus Handbook for more details 
// https://stimulusjs.org/handbook/introduction
// 
// This example controller works with specially annotated HTML like:
//
// <div data-controller="current-ask">
// </div>

import { Controller } from "stimulus"
import { todoMessagesChannel } from "../channels/todo_messages_channel"

export default class extends Controller {
  static targets = ['task']

  connect() {
    todoMessagesChannel.received = (data) => {
      if (data['status'] == 'active') {
        this.taskTarget.innerHTML = data['message_html'];
        this.taskTarget.dataset.currentId = data['id'];
      } else if (this.taskTarget.dataset.currentId == data['id']) {
        this.taskTarget.innerHTML = '';
        this.taskTarget.dataset.currentId = '0';
      }
    }
  }
}
