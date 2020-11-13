// Visit The Stimulus Handbook for more details 
// https://stimulusjs.org/handbook/introduction
// 
// This example controller works with specially annotated HTML like:
//
// <div data-controller="comfy">
//   <h1 data-target="comfy.output"></h1>
// </div>

import ApplicationController from './application_controller'
require("comfy.js")

export default class extends ApplicationController {
  connect() {
    super.connect()

    this.init(
      this.data.get('channel'),
      this.data.get('token')
    )
  }

  init(channel, token) {
    ComfyJS.onError = (error) => {
      console.log('ERROR:', error)
      window.location = "/sign_out?return_to=/overlay";
    };
    ComfyJS.Init(this.data.get('channel'), `oauth:${token}`)

    ComfyJS.onChat = ( user, message, flags, self, extra ) => {
      this.stimulate('Twitch#chat',
        extra.id,
        extra.channel,
        message,
        extra.messageEmotes,
        user,
        extra.userColor
      );
    }

    ComfyJS.onCommand = ( user, command, message, flags, extra ) => {
      this.stimulate('Twitch#command',
        extra.id,
        extra.channel,
        command,
        message,
        user,
        extra.userColor
      );
    }
  }
}
