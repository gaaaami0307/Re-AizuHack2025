document.addEventListener("DOMContentLoaded", () => {
  const next = document.getElementById("next");
  const taskList = document.getElementById("task-list");

  next.addEventListener("submit", (e) => {
    if (taskList.children.length === 0) {// タスクリストが空の場合
      e.preventDefault(); // ページ遷移をキャンセル
    alert("やることが1つも登録されていません！");
    }
  });
});