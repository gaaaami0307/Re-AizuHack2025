//HTML読み込み後に実行されるスクリプトと定義もろもろ//
document.addEventListener("DOMContentLoaded", () => {
  const submitForm = document.getElementById("submit-form");
  const rangeT = document.getElementById("feedback-range-time");
  const rangeC = document.getElementById("feedback-range-consentrate");
  const rangeM = document.getElementById("feedback-range-motiveation");
  const epField = document.getElementById("epField");

  //送信ボタン
  submitForm.addEventListener("submit", (e) => {
    e.preventDefault();
    
    //---POSTリクエスト送信

    // 今日の日付を "YYYY-MM-DD" 形式で取得
    const today = new Date().toISOString().split('T')[0];

    //トークン取得
    const token = document.querySelector('meta[name="csrf-token"]').content;

    fetch(`/feedbacks`, {
      method: 'POST',
      headers: {
        'X-CSRF-Token': token,
        'Content-Type': 'application/json',
      },
      body: JSON.stringify({
        "feed_back":{
          date: today,
          ep : epField.value,
          tf: parseInt(rangeT.value),
          con: parseInt(rangeC.value),
          mtv: parseInt(rangeM.value)
        }
      })
    }).then(response => {
      window.location.href = '/tops/';
    }).catch(error =>{
      alert(error);
      return;
    })
  });

});
