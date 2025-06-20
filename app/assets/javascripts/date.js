const today = new Date();

const month = today.getMonth() + 1;
const day = today.getDate();
const week = today.getDay();
const week_ja = ["日", "月", "火", "水", "木", "金", "土"];

const dateString = `${month}月${day}日（${week_ja[week]}）`;
document.getElementById("today").textContent = dateString;