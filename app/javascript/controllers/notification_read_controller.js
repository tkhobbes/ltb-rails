import { Controller } from "@hotwired/stimulus";
import { post, destroy } from "@rails/request.js";

// Connects to data-controller="notification-read"
export default class extends Controller {
  static values = { id: Number };

  markAsReadMenu() {
    post(`/notifications/${this.idValue}/read?menu=true`);
  }

  markAsRead() {
    post(`/notifications/${this.idValue}/read`);
  }
}
