import { Controller } from "@hotwired/stimulus";
import TomSelect from "tom-select";

// Connects to data-controller="tags-input"
export default class extends Controller {
  connect() {
    new TomSelect(this.element, {
      plugins: {
        remove_button: {
          title: "Remove Item",
        },
      },
    });
  }
}
