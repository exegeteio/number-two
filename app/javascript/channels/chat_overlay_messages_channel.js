import consumer from "./consumer"

export const chatOverlayMessagesChannel = consumer.subscriptions.create("ChatOverlayMessagesChannel", {
  connected() {
    // Called when the subscription is ready for use on the server
    console.log("ChatOverlayMessagesChannel connected")
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
  },

  received(data) {
    // Called when there's incoming data on the websocket for this channel
    console.log('Chat overlay received', data)
  }
});
