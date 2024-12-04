import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  connect() {
    this.element.addEventListener("input", this.formatPhone.bind(this));
  }

  formatPhone(event) {
    let value = this.element.value.replace(/\D/g, ""); // Remove non-digit characters
    if (value.length > 3 && value.length <= 6) {
      value = `${value.slice(0, 3)}-${value.slice(3)}`;
    } else if (value.length > 6) {
      value = `${value.slice(0, 3)}-${value.slice(3, 6)}-${value.slice(6, 10)}`;
    }
    this.element.value = value;
  }
}
