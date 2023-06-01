import { Controller } from "@hotwired/stimulus";
import TomSelect from "tom-select";
import { I18n } from "i18n-js";
import { translations } from "../../../config/locales/locales.json";

// Connects to data-controller="tags-input"
export default class extends Controller {
  static values = {
    locale: String,
  };
  connect() {
    const i18n = new I18n(translations);
    i18n.locale = this.localeValue;
    new TomSelect(this.element, {
      plugins: {
        remove_button: {
          title: i18n.t("tags-input.remove-tag"),
        },
      },
    });
  }
}
