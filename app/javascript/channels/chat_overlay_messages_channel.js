import CableReady from 'cable_ready'
import consumer from "./consumer"


export const buildChatOverlayMessagesChannel = function(twitch_channel) {
  return consumer.subscriptions.create(
    {
      channel: "ChatOverlayMessagesChannel",
      twitch_channel: twitch_channel,
    },
    {
      connected() {
        // Called when the subscription is ready for use on the server
        console.log(`ChatOverlayMessagesChannel connected: ${twitch_channel}`);
      },

      disconnected() {
        // Called when the subscription has been terminated by the server
      },

      received(data) {
        console.log('chat_overlay_messages_channel', data);
        if (data.cableReady) CableReady.perform(data.operations);
      }
    }
  );
}