  const pay = () => {
    const payjp = Payjp('pk_test_572db5838539f54d2e1be7b5')// PAY.JPテスト公開鍵
    const elements = payjp.elements();
    const numberElement = elements.create('cardNumber');
    const expiryElement = elements.create('cardExpiry');
    const cvcElement = elements.create('cardCvc');

    numberElement.mount('#number-form');
    expiryElement.mount('#expiry-form');
    cvcElement.mount('#cvc-form');
    const form = document.getElementById("button"); // フォームのIDを指定
    
    if (form) {
      form.addEventListener("submit", (e) => {
        console.log("購入ボタンが押されました");
        payjp.createToken(numberElement).then(function (response) {
          if (response.error) {
          } else {
            const token = response.id;
            const renderDom = document.getElementById("charge-form");
            const tokenObj = `<input value=${token} name='token' type="hidden">`;
            renderDom.insertAdjacentHTML("beforeend", tokenObj);
          }
          numberElement.clear();
          expiryElement.clear();
          cvcElement.clear();
          document.getElementById("charge-form").submit();
        });
        e.preventDefault();
  
        // ここに後続の処理を追加します（例: カード情報の取得など）
      });
    } else {
      console.error("フォーム要素が見つかりません。");
    }
  };
  
  window.addEventListener("turbo:load", pay);