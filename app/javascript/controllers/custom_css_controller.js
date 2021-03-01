import { Controller } from "stimulus"

export default class extends Controller {
	static targets = ['style'];
	connect() {
		fetch(this.data.get('url'))
			.then((resp) => {
				if (!resp.ok) {
					alert("Error fetching custom CSS: " + resp.status);
				}
				return resp;
			})
			.catch((error) => {
				console.log(error);
			})
			.then(data => data.text())
			.then((content) => {
				this.styleTarget.innerText = content;
			});
	}
}
