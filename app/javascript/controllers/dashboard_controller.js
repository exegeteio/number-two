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

    this.interval = setInterval(() => { this.getSubPoints() }, 60_000);
    this.getSubPoints();

    this.init(
      this.data.get('channel'),
      this.data.get('token')
    )
  }

  disconnect() {
    clearInterval(this.interval);
  }

  getSubPoints(offset=undefined) {
    console.log(`Fetching subpoints with offset: ${offset}`)
    fetch( `https://api.twitch.tv/helix/subscriptions?broadcaster_id=${this.data.get('userid')}&offset=${offset}`, {
        headers: {
            "Client-ID": this.data.get('client-id'),
            "Authorization": `Bearer ${this.data.get('token')}`,
        }
    } )
    .then( r => r.json() )
    .then( r => {
        let points = this.data.get("subpoints") || 0;

        r["data"].forEach(sub => {
          switch (o.tier) {
            case '1000': {
              points++;
              break;
            }
            case '2000': {
              points = points + 2;
              break;
            }
            case '3000': {
              points = points + 6;
              break;
            }
          }
        });

        this.data.set("subpoints", points);

        if (r["pagination"]["cursor"]) {
          this.getSubPoints(r["pagination"]["cursor"]);
        } else {
          this.stimulate('Subpoints#update', points);
        }
    })
    .catch( error => {
        // Auth Failed
        return {
            error: error
        };
    });
  }

  init(channel, token) {
    ComfyJS.onError = (error) => {
      console.log('ERROR:', error)
      window.location = "/sign_out?return_to=/overlay";
    };
    ComfyJS.Init(this.data.get('channel'), `oauth:${token}`)

    ComfyJS.onChat = ( user, message, flags, self, extra ) => {
      console.log(user, message, flags, self, extra);
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
