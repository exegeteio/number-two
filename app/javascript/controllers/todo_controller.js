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
  static targets = ['tasks']

  connect() {
    todoMessagesChannel.received = (data) => {
      this.tasksTarget.insertAdjacentHTML('beforeend', data)
    }
  }
}
