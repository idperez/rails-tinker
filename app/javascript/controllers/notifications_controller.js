import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
	close(e) {
		const notificationId = e.currentTarget.dataset.notificationId;
		document.getElementById(notificationId).remove();
	}
}
