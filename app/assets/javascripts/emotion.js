//HTML読み込み後に実行されるスクリプトと定義もろもろ//
document.addEventListener("DOMContentLoaded", () => {
  const form = document.getElementById("emotion-form");
  const submitForm = document.getElementById("submit-form");
  const range = document.getElementById("duration-range");
  const emotionInput = document.getElementById("emotion-input");
  const submitButton = document.getElementById("submit-button");
  //この下２つは表示用の要素
  const displayDuration = document.getElementById("display-duration");
  const displayEmotion = document.getElementById("display-emotion");

  // スライダー変更時にリアルタイム更新
  range.addEventListener("input", () => { //range監視
    const time = parseFloat(range.value).toFixed(2); //おまじない (がみです。小数第二位のやつだと思います)
    displayDuration.textContent = time;
  });

  // ページのリフレッシュをここで止める
  form.addEventListener("submit", (e) => {
    e.preventDefault();

    const emotion = emotionInput.value.trim();
    const time = parseFloat(range.value);

    //感情と作業時間を表示する
    displayEmotion.textContent = emotion;
    emotionInput.value = ""; // 入力欄リセット
  });

  //送信ボタン
  submitForm.addEventListener("submit", (e) => {
    e.preventDefault();

    //気分が空||未入力の場合
    if (displayEmotion.textContent === "" || displayEmotion.textContent === "（未入力）") {
      alert("気分が入力されていません！");
      return;
    }

    //作業時間0の場合
    if (parseFloat(range.value) === 0) {
      alert("作業時間を入力してください！");
      return;
    }
    
    //POSTリクエスト送信

    // 今日の日付を "YYYY-MM-DD" 形式で取得
    const today = new Date().toISOString().split('T')[0];

    //トークン取得
    const token = document.querySelector('meta[name="csrf-token"]').content;

    fetch(`/options/`, {
      method: 'POST',
      headers: {
        'X-CSRF-Token': token,
        'Content-Type': 'application/json',
      },
      body: JSON.stringify({
        date: today,
        emotion: displayEmotion.textContent,
        maxtime: parseFloat(range.value)
      })
    }).then(response => {
      window.location.href = '/tops/';
    }).catch(error =>{
      alert("入力エラー");
      return;
    })
  });

});
