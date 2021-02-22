import { Controller } from "stimulus"
import { MessageChannel } from "../channels/message_channel"
require('comfy.js')

export default class extends Controller {
	connect() {
		let channel = this.data.get('channel');
		console.log(`Connecting to ${channel}...`);

		// Log errors from ComfyJS.
		ComfyJS.onError = (error) => {
			console.log('ERROR:', error)
		};

		// Connect to Twitch websocket and start receiving.
		ComfyJS.Init(channel);

		// On each chat message...
		ComfyJS.onChat = (user, message, flags, self, extra) => {
			console.log("onChat", user, message);
			// Send over ActionCable.
			MessageChannel.send({
				channel: channel,
				from_username: user,
				content: message,
				kind: "chat"
			});
		};

		// On each "command" (anything starting with a "!")...
		ComfyJS.onCommand = (user, command, message, flags, extra) => {
			console.log("onCommand", user, command, message);
			// Send over ActionCable.
			MessageChannel.send({
				channel: channel,
				from_username: user,
				content: message,
				kind: command
			});
		};
	}
}
