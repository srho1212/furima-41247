const price = () => {
  // 金額を入力した数値をpriceInputという変数に格納する
  const priceInput = document.getElementById("item-price");
  const addTaxDom = document.getElementById("add-tax-price");
  const profitDom = document.getElementById("profit");

  if (priceInput && addTaxDom && profitDom) { // 要素が存在するか確認
      priceInput.addEventListener("input", () => {
          const inputValue = parseFloat(priceInput.value); // 入力値を浮動小数点数に変換

          if (!isNaN(inputValue)) { // 入力値が有効な数値であるかチェック
              const feeRate = 0.1; // 例えば10%の手数料率
              const rawFee = inputValue * feeRate;
              const fee = Math.floor(rawFee); // 手数料を切り捨てる
              const netProfit = inputValue - fee;

              addTaxDom.innerHTML = ` ${fee.toFixed()}`;
              profitDom.innerHTML = `${netProfit.toFixed()}`; // 利益を更新
          } else {
              addTaxDom.innerHTML = "有効な金額を入力してください。";
              profitDom.innerHTML = "";
          }
      });
  } else {
      console.error("priceInput、addTaxDomまたはprofitDomが見つかりません。");
  }
};

window.addEventListener('turbo:load', price);
window.addEventListener('turbo:render', price);