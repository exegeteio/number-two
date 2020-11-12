import CableReady from 'cable_ready'
import consumer from "./consumer"

export const twitchMessagesChannel = consumer.subscriptions.create(
  "TwitchMessagesChannel", {
    connected() {
      // Called when the subscription is ready for use on the server
      console.log('TwitchMessageChannel connected')
    },

    disconnected() {
      // Called when the subscription has been terminated by the server
    },

    received(data) {
      if (data.cableReady) CableReady.perform(data.operations);
    }
  }
);
