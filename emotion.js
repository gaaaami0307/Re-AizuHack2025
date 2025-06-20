//HTML読み込み後に実行されるスクリプトと定義もろもろ//
document.addEventListener("DOMContentLoaded", () => {
  const form = document.getElementById("emotion-form");
  const range = document.getElementById("duration-range");
  const emotionInput = document.getElementById("emotion-input");
  //この下２つは表示用の要素
  const displayDuration = document.getElementById("display-duration");
  const displayEmotion = document.getElementById("display-emotion");

  // スライダー変更時にリアルタイム更新
  range.addEventListener("input", () => { //range監視
    const time = parseFloat(range.value).toFixed(2); //おまじない
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
});
