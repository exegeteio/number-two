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

export default class extends Controller {
  connect() {
    ComfyJS.Init("exegete46")
    ComfyJS.onChat = ( user, message, flags, self, extra ) => {
      // console.log( user, message, flags, self, extra );
      twitchMessagesChannel.send({
        ... flags,
        ... extra,
        user: user,
        message: message,
      })
    }
    ComfyJS.onCommand = ( user, command, message, flags, extra ) => {
      console.log( "TODO: Handle commands!", user, command, message, flags, extra );
      // twitchCommandChannel.send({
      //   ... flags,
      //   ... extra,
      //   command: command,
      //   user: user,
      //   message: message,
      // })
    }
  }
}
