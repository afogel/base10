import { Controller } from "@hotwired/stimulus";
import { get } from "@rails/request.js";

// Connects to data-controller="toggle-drawer"
export default class extends Controller {
  static targets = ["checkbox", "frame"];
  static values = { url: String };

  toggle(event) {
    this.checkboxTarget.checked = !this.checkboxTarget.checked;
    event.params = {
      url: event.target.parentElement.dataset.url,
    };
    this.load(event);
  }

  async load(event) {
    get(event.params.url, {
      responseKind: "turbo-stream",
      query: {
        annualized:
          event.target.value && event.target.checked === false ? false : true,
      },
    });
  }
}
