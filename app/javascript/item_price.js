const price = () => {
    const priceInput = document.getElementById("item-price");
    const addTaxDom = document.getElementById("add-tax-price");
    const profitDom = document.getElementById("profit");

    if (priceInput && addTaxDom && profitDom) {
        priceInput.addEventListener("input", () => {
            const inputValue = parseFloat(priceInput.value);
            if (!isNaN(inputValue)) {
                const feeRate = 0.1;
                const fee = Math.floor(inputValue * feeRate);
                const netProfit = inputValue - fee;

                addTaxDom.innerHTML = fee.toLocaleString();
                profitDom.innerHTML = netProfit.toLocaleString();
            } else {
                addTaxDom.innerHTML = "0";
                profitDom.innerHTML = "0";
            }
        });
    } else {
        console.error("必要なDOM要素が見つかりません。");
    }
};

window.addEventListener('turbo:load', price);
window.addEventListener('turbo:render', price);
