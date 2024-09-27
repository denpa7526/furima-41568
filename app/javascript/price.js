const price = () => {
  const itemPrice = document.getElementById("item-price");
  const addTaxPrice = document.getElementById("add-tax-price");
  const profit = document.getElementById("profit");

  if (itemPrice) {
    itemPrice.addEventListener("input", () => {
      const priceVal = itemPrice.value;
      const tax = Math.floor(priceVal * 0.1 );
      const profitVal = Math.floor(priceVal - tax);

      addTaxPrice.innerHTML = tax;
      profit.innerHTML = profitVal;
    });
  }
};

window.addEventListener("turbo:load", price);
window.addEventListener("turbo:render", price);