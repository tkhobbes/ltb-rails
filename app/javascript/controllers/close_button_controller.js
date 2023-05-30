import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="close-button"
export default class extends Controller {
  connect() {
    setTimeout(() => {
      this.element.remove();
    }, 3000);
  }
  click() {
    this.element.remove();
  }
}
