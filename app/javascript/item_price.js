window.addEventListener('turbo:load', () => {
  console.log("OK");
});
// 金額を入力した数値をpriceInputという変数に格納する
const priceInput = document.getElementById("item-price");
priceInput.addEventListener("input", () => {
  console.log("イベント発火");
})