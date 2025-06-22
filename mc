const $ = new Env("网易云音乐Cookie");

if (typeof $request !== "undefined") {
  // 获取 Cookie 和 User-Agent
  const cookie = $request.headers["Cookie"] || $request.headers["cookie"];
  const ua = $request.headers["User-Agent"] || $request.headers["user-agent"];

  // 调试输出，查看是否正确获取 Cookie 和 User-Agent
  console.log("请求头中获取到的Cookie:", cookie);   // 这会打印获取到的 Cookie
  console.log("请求头中获取到的User-Agent:", ua);   // 这会打印获取到的 User-Agent

  if (cookie && ua) {
    // 保存 Cookie 和 User-Agent
    $.setdata(cookie, "Netease_Musician_Cookie");
    $.setdata(ua, "Netease_Musician_UserAgent");

    // 显示成功消息
    $.msg("网易云音乐", "🎉 Cookie获取成功！", "请开始定时任务");
    $.done();
  } else {
    $.msg("网易云音乐", "⚠️ Cookie获取失败", "请求头中无Cookie信息");
    $.done();
  }
} else {
  $.msg("网易云音乐", "⚠️ 请勿手动运行", "");
  $.done();
}

function Env(t, e) {
  return new class {
    constructor(t, e) {
      this.name = t;
      this.data = null;
    }
    getdata(key) { return $persistentStore.read(key); }
    setdata(val, key) { return $persistentStore.write(val, key); }
    msg(title, subtitle, message) { $notification.post(title, subtitle, message); }
    done(val) { $done(val); }
  }(t, e);
}
