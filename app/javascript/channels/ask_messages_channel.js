import CableReady from 'cable_ready'
import consumer from "./consumer"

export const buildAskMessagesChannel = function (twitch_channel) {
  return consumer.subscriptions.create(
    {
      channel: "AskMessagesChannel",
      twitch_channel: twitch_channel,
    },
    {
      connected() {
        // Called when the subscription is ready for use on the server
        console.log(`Connected to AskMessagesChannel: ${twitch_channel}`);
      },

      disconnected() {
        // Called when the subscription has been terminated by the server
      },

      received(data) {
        console.log("TODO:  Remove this!", data);
        if (data.cableReady) CableReady.perform(data.operations);
      }
    }
  );
};
