import CableReady from 'cable_ready'
import consumer from "./consumer"

export const twitchCommandsChannel = consumer.subscriptions.create("TwitchCommandsChannel", {
  connected() {
    // Called when the subscription is ready for use on the server
    console.log('TwitchCommandsChannel connected')
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
  },

  received(data) {
    if (data.cableReady) CableReady.perform(data.operations);
  }
});
