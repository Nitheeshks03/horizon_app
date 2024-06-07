import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="filter"
export default class extends Controller {
  static targets = ["category"];
  connect() {
    console.log("filter controller connected");
  }

  category() {
    this.element.requestSubmit();
  }
}
