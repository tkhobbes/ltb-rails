import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="inlay-select"
export default class extends Controller {
  static values = {
    list: String,
  };

  connect() {
    console.log("connected from ") + this.listValue;
  }

  toggle() {
    console.log("toggled from ") + this.listValue;
  }
}
