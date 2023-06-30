import { Controller } from "@hotwired/stimulus";
import { toast } from "bulma-toast";

// Connects to data-controller="close-button"
export default class extends Controller {
  static values = { message: String, type: String };
  connect() {
    toast({
      message: this.messageValue,
      type: this.typeValue,
      duration: 10000,
      dismissible: true,
      position: "top-center",
      pauseOnHover: true,
      closeOnClick: true,
      opacity: 0.9,
    });
  }
}
