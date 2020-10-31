// Visit The Stimulus Handbook for more details 
// https://stimulusjs.org/handbook/introduction
// 
// This example controller works with specially annotated HTML like:
//
// <div data-controller="comfy">
//   <h1 data-target="comfy.output"></h1>
// </div>

import { Controller } from "stimulus"
require("comfy.js")
import { twitchMessagesChannel } from "../channels/twitch_messages_channel"
import { twitchCommandsChannel } from "../channels/twitch_commands_channel"

export default class extends Controller {
  static targets = ['signIn', 'signOut', 'welcome']

  connect() {
    this.init(
      this.data.get('channel'),
      this.data.get('token')
    )
  }

  init(channel, token) {
    ComfyJS.Init(this.data.get('channel'), `oauth:${token}`);
    this.welcomeTarget.textContent = `${channel} Dashboard`;

    ComfyJS.onChat = ( user, message, flags, self, extra ) => {
      twitchMessagesChannel.send({
        ... flags,
        ... extra,
        user: user,
        message: message,
      })
    }

    ComfyJS.onCommand = ( user, command, message, flags, extra ) => {
      twitchCommandsChannel.send({
        ... flags,
        ... extra,
        command: command,
        user: user,
        message: message,
      })
    }
  }
}
