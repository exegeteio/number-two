import consumer from "./consumer"

export const buildAskMessagesChannel = function (twitch_channel) {
  return consumer.subscriptions.create("AskMessagesChannel",
    {
      channel: "ChatOverlayMessagesChannel",
      twitch_channel: twitch_channel,
    }
  );
};
