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
require("comfytwitch.js")
import { twitchMessagesChannel } from "../channels/twitch_messages_channel"
import { twitchCommandsChannel } from "../channels/twitch_commands_channel"

export default class extends Controller {
  static targets = ['signIn', 'signOut', 'welcome']

  connect() {
    ComfyTwitch.Check().then(result => {
      if (result) { // Logged in.
        this.showSignOut();
        ComfyTwitch.GetUser( this.data.get('client-id'), result.user_id ).then(user => {
          console.log(`Connecting to Twitch chat channel: ${user.login}`);
          this.init(user)
        });
      } else {
        this.showSignIn();
      }
    });

  }

  init(auth_user) {
    ComfyJS.Init(window.localStorage.getItem( "channel" ) || ComfyTwitch.User, `oauth:${ComfyTwitch.Token}`);
    this.welcomeTarget.textContent = `${auth_user.login} Dashboard`

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

  showSignIn() {
    this.signInTarget.classList.add('in');
    this.signOutTarget.classList.remove('in');
  }

  showSignOut() {
    this.signOutTarget.classList.add('in');
    this.signInTarget.classList.remove('in');
  }

  signIn() {
    const baseUrl = window.location.origin + window.location.pathname;
    const cb_scopes = [ "user:read:email", "chat:read", "chat:edit", "channel:moderate", "whispers:read", "whispers:edit", "channel:read:redemptions" ];
    ComfyTwitch.Login(
      this.data.get("client-id"),
      baseUrl,
      cb_scopes
    );
  }

  signOut() {
    ComfyTwitch.Logout();
    window.location.reload();
  }
}
