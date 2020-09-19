// Visit The Stimulus Handbook for more details 
// https://stimulusjs.org/handbook/introduction
// 
// This example controller works with specially annotated HTML like:
//
// <div data-controller="current-ask">
// </div>

import { Controller } from "stimulus"
import { currentTodoChannel } from "../channels/current_todo_channel"

export default class extends Controller {
  static targets = ['task']

  connect() {
    currentTodoChannel.received = (data) => {
      this.taskTarget.innerHTML = data['content']
    }
  }
}
