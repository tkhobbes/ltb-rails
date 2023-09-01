import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="inlay-select"
export default class extends Controller {
  static values = {
    bookid: String,
  };

  connect() {}

  toggle(e) {
    e.preventDefault();
    const selected_book = this.element;

    if (this.element.parentElement.id === "full") {
      // we remove from the full list and add to the selected list
      document.getElementById("full").removeChild(selected_book);
      document.getElementById("selected").appendChild(selected_book);
      document.getElementById("bookids").value += this.bookidValue + ",";
    } else {
      // we remove from the selected list and add to the full list
      document.getElementById("selected").removeChild(selected_book);
      document.getElementById("full").appendChild(selected_book);
      document.getElementById("bookids").value = document
        .getElementById("bookids")
        .value.replace(this.bookidValue + ",", "");
    }
  }
}
