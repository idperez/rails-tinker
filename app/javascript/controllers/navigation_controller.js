import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
	goTo(e) {
		e.preventDefault();
		window.location.replace(e.currentTarget.dataset.path)
	}
}
