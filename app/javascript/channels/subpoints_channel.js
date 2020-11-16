import CableReady from 'cable_ready'
import consumer from "./consumer"

export const buildSubpointsChannel = function(twitch_channel) {
  return consumer.subscriptions.create(
    {
      channel: "SubpointsChannel",
      twitch_channel: twitch_channel,
    },
    {
      connected() {
        // Called when the subscription is ready for use on the server
        console.log(`Connected to SubpointsChannel: ${twitch_channel}`);
      },

      disconnected() {
        // Called when the subscription has been terminated by the server
      },

      received(data) {
        if (data.cableReady) CableReady.perform(data.operations);
      }
    }
  );
};