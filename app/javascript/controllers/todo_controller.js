// Visit The Stimulus Handbook for more details 
// https://stimulusjs.org/handbook/introduction
// 
// This example controller works with specially annotated HTML like:
//
// <div data-controller="ask">
//   <h1 data-target="ask.output"></h1>
// </div>

import { Controller } from "stimulus"
import { todoMessagesChannel } from "../channels/todo_messages_channel"

export default class extends Controller {
  static targets = ['container', 'todos']
  hide_statuses = ['completed', 'deleted']

  connect() {
    todoMessagesChannel.received = (data) => {
      let replaced = 0;
      this.todosTargets.forEach(element => {
        if (element.dataset.id == data['id']) {
          if (this.hide_statuses.includes(data['status'])) {
            element.outerHTML = '';
          } else {
            element.outerHTML = data['html'];
          }
          replaced++;
        }
      });
      if (replaced == 0) {
        this.containerTarget.insertAdjacentHTML('beforeend', data['html'])
      }
    }
  }
}
