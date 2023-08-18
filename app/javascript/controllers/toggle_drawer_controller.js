import { Controller } from "@hotwired/stimulus";
import { get } from "@rails/request.js";

// Connects to data-controller="toggle-drawer"
export default class extends Controller {
  static targets = ["checkbox"];
  static values = { url: String };

  toggle(event) {
    debugger;
    this.checkboxTarget.checked = !this.checkboxTarget.checked;
    get(event.target.parentElement.dataset.url, {
      responseKind: "turbo-stream",
    });
  }
}
