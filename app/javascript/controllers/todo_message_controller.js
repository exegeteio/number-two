// Visit The Stimulus Handbook for more details 
// https://stimulusjs.org/handbook/introduction
// 
// This example controller works with specially annotated HTML like:
//
// <div data-controller="chat-message">
// </div>

import { Controller } from "stimulus"
import { currentTodoChannel } from "../channels/current_todo_channel"

export default class extends Controller {
  static targets = ['task', 'delete'];

  delete() {
    this.element.remove();
  }

  promote() {
    currentTodoChannel.send({content: this.taskTarget.outerHTML})
    this.element.classList.add('current')
    this.deleteTarget.remove();
  }

  complete() {
    currentTodoChannel.send({content: ''})
    this.delete()
  }
}
