import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["totalAmount", "split", "personalPayout"]

  connect() {
    this.updatePersonalPayout()
    this.totalAmountTarget.addEventListener("input", this.updatePersonalPayout.bind(this))
    this.splitTargets.forEach(splitTarget => {
      splitTarget.addEventListener("input", this.updatePersonalPayout.bind(this))
    })
  }

  updatePersonalPayout() {
    const totalAmount = parseFloat(this.totalAmountTarget.value)
    const split = parseInt(this.selectedSplitValue)

    if (!isNaN(totalAmount) && !isNaN(split) && split > 0) {
      const personalPayout = totalAmount / split
      this.personalPayoutTarget.value = personalPayout.toFixed(2)
    } else {
      this.personalPayoutTarget.value = ""
    }
  }

  get selectedSplitValue() {
    const selectedSplitInput = this.splitTarget.querySelector("input[type='radio']:checked")
    return selectedSplitInput ? selectedSplitInput.value : null
  }

  get splitTarget() {
    return this.element.querySelector("[data-tip-calc-target='split']")
  }
}