import { Controller } from "stimulus"

export default class extends Controller {
	static targets = ["value"]

	copy() {
		this.valueTarget.select();
		document.execCommand("copy")
		alert('Copied!');
	}
}
