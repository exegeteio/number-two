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
      // Called when there's incoming data on the websocket for this channel
    }
  }
);
