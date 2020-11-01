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
        // Called when there's incoming data on the websocket for this channel
      }
    }
  );
};
