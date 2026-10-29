import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="commands"
export default class extends Controller {
  static targets = [ "panel" ]
  connect() {
  }

  toggle() {
    this.panelTarget.hidden = !this.panelTarget.hidden
  }
}
