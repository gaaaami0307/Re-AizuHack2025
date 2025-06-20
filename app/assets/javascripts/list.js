document.addEventListener("DOMContentLoaded", () => {
  const form = document.getElementById("task-form");
  
  if (form) {
    const input = form.querySelector("input");

    let taskList = document.getElementById("task-list");
    if (!taskList) { //上行で取得時taskListが存在しない(初回ロード時)は新規作成
      taskList = document.createElement("ul");
      taskList.id = "task-list-js";//ul要素にIDを設定
      form.after(taskList);
    }
  }

  //タスクにイベントを追加
  document.querySelectorAll(".task-text").forEach((span) => {
    span.addEventListener("click", () => {
      span.classList.toggle("done");
    });
  });

  //×ボタンにイベントを追加
  
  document.querySelectorAll(".delete-btn").forEach((deleteBtn) => {
    deleteBtn.addEventListener("click", () => {
      const taskid = deleteBtn.dataset.taskId;

      //トークン取得
      const token = document.querySelector('meta[name="csrf-token"]').content;
    
      fetch(`/tops/${taskid}`, {
        method: 'DELETE',
        headers: {
          'X-CSRF-Token': token,
          'Content-Type': 'application/json',
          'Accept': 'application/json'
        },
      }).then(response => {
        window.location.href = '/tops/';
      }).catch(error =>{
        alert(error);
        return;
      })

    })
  });
  

  //railsで代用
  /*
  form.addEventListener("submit", (e) => {
    e.preventDefault();//フォームのデフォルト送信を防ぐ

    const task = input.value.trim();
    if (task === "") return;// 入力が空の場合は何もしない(空白でも同様に無視)

    /*
    const li = document.createElement("li");

    const span = document.createElement("span"); // タスクテキスト用
    
    span.textContent = task;
    span.classList.add("task-text");


    //  タスク完了時の切り替え
    span.addEventListener("click", () => {
      span.classList.toggle("done");
    });

    */
    /*
    // ✕ボタン
    const deleteBtn = document.createElement("button");
    deleteBtn.textContent = "✕";
    deleteBtn.className = "delete-btn";
    // リストごと消去↓
    deleteBtn.addEventListener("click", () => {
      li.remove();
    });

    li.appendChild(span);
    li.appendChild(deleteBtn);
    taskList.appendChild(li);
    input.value = "";

  });
  */
});
