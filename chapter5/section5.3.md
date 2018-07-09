# 同源政策

受同源限制有如下几点：
- Cookie、LocalStorage 和 IndexedDB 无法读取。
- DOM 无法获得。
- AJAX 请求无效（可以发送，但浏览器会拒绝接受响应）。
## Cookie
两个网页一级域名相同，只是二级域名不同，浏览器允许通过设置document.domain共享 Cookie。

```js
// A网页是http://w1.example.com/a.html，B网页是http://w2.example.com/b.html
document.domain = 'example.com';

// 现在，A 网页通过脚本设置一个 Cookie。
document.cookie = "test1=hello";

// B 网页就可以读到这个 Cookie。
var allCookie = document.cookie;
```
服务器也可以在设置 Cookie 的时候，指定 Cookie 的所属域名为一级域名，比如.example.com。
```js
Set-Cookie: key=value; domain=.example.com; path=/
```
这样的话，二级域名和三级域名不用做任何设置，都可以读取这个Cookie。

## Iframe
iframe窗口之中的脚本，可以获得父窗口和子窗口。但是，只有在同源的情况下，父窗口和子窗口才能通信；如果跨域，就无法拿到对方的DOM。
```js
// 父窗口运行下面的命令，如果iframe窗口不是同源，就会报错。
document.getElementById("myIFrame").contentWindow.document
// Uncaught DOMException: Blocked a frame from accessing a cross-origin frame.

// 窗口获取主窗口的DOM也会报错。
window.parent.document.body
// 报错
```
这种情况还适用于window.open方法打开的窗口，只要跨域，父窗口与子窗口之间就无法通信。

如果两个窗口一级域名相同，只是二级域名不同，那么设置上一节介绍的document.domain属性，就可以规避同源政策，拿到DOM。

对于完全不同源的网站，目前有两种方法，可以解决跨域窗口的通信问题。
- 片段识别符（fragment identifier）
- 跨文档通信API（Cross-document messaging）

### 片段识别符
URL的#号后面的部分。如果只是改变片段标识符，页面不会重新刷新。

```js
// 父窗口可以把信息，写入子窗口的片段标识符。
var src = originURL + '#' + data;
document.getElementById('myIFrame').src = src;

// 子窗口通过监听hashchange事件得到通知。
window.onhashchange = checkMessage;

function checkMessage() {
  var message = window.location.hash;
  // ...
}

// 同样的，子窗口也可以改变父窗口的片段标识符。
parent.location.href= target + '#' + hash;
```

### 跨文档通信API(window.postMessage)
postMessage方法的第一个参数是具体的信息内容，第二个参数是接收消息的窗口的源（origin），即“协议 + 域名 + 端口”。也可以设为*，表示不限制域名，向所有窗口发送。
```js
// 父窗口aaa.com向子窗口bbb.com发消息
var popup = window.open('http://bbb.com', 'title');
popup.postMessage('Hello World!', 'http://bbb.com');

// 子窗口向父窗口发送消息的写法类似。
window.opener.postMessage('Nice to see you', 'http://aaa.com');

// 父窗口和子窗口都可以通过message事件，监听对方的消息。
window.addEventListener('message', function(e) {
  console.log(e.data);
},false);
```
event对象的几个属性：
- event.source：发送消息的窗口
- event.origin: 消息发向的网址
- event.data: 消息内容

window.postMessage，也可以读写其他窗口的 LocalStorage

```js
// 主窗口写入iframe子窗口的localStorage
window.onmessage = function(e) {
  if (e.origin !== 'http://bbb.com') {
    return;
  }
  var payload = JSON.parse(e.data);
  localStorage.setItem(payload.key, JSON.stringify(payload.data));
};

// 父窗口发送消息的代码如下。
var win = document.getElementsByTagName('iframe')[0].contentWindow;
var obj = { name: 'Jack' };
win.postMessage(JSON.stringify({key: 'storage', data: obj}), 'http://bbb.com');
```

## Ajax
跨域解决：
- JSONP
- WebSocket
- CORS

### JONP
它的基本思想是，网页通过添加一个<script>元素，向服务器请求JSON数据，这种做法不受同源政策限制；服务器收到请求后，将数据放在一个指定名字的回调函数里传回来。

```js
function addScriptTag(src) {
  var script = document.createElement('script');
  script.setAttribute("type","text/javascript");
  script.src = src;
  document.body.appendChild(script);
}

window.onload = function () {
  addScriptTag('http://example.com/ip?callback=foo');
}

function foo(data) {
  console.log('Your public IP address is: ' + data.ip);
};
```
服务器收到这个请求以后，会将数据放在回调函数的参数位置返回。
```js
foo({
  "ip": "8.8.8.8"
});
```

### WebSocket(ws协议)
该协议不实行同源政策，只要服务器支持，就可以通过它进行跨源通信。

浏览器发出的WebSocket请求的头信息
```js
GET /chat HTTP/1.1
Host: server.example.com
Upgrade: websocket
Connection: Upgrade
Sec-WebSocket-Key: x3JJHMbDL1EzLkh9GBhXDw==
Sec-WebSocket-Protocol: chat, superchat
Sec-WebSocket-Version: 13
Origin: http://example.com
```
服务器可以根据Origin这个字段，判断是否许可本次通信。如果该域名在白名单内，服务器就会做出如下回应。
```js
HTTP/1.1 101 Switching Protocols
Upgrade: websocket
Connection: Upgrade
Sec-WebSocket-Accept: HSmrc0sMlYUkAGmm5OPpG2HaGWk=
Sec-WebSocket-Protocol: chat
```

### CORS(跨源资源分享)
相比JSONP只能发GET请求，CORS允许任何类型的请求。

只要服务器实现了CORS接口，就可以跨源通信。

```js
// 简单请求
// request
GET /cors HTTP/1.1
Origin: http://api.bob.com
Host: api.alice.com
Accept-Language: en-US
Connection: keep-alive
User-Agent: Mozilla/5.0...

// response
Access-Control-Allow-Origin: http://api.bob.com
// 默认情况下，Cookie不包括在CORS请求之中。设为true，即表示服务器明确许可，Cookie可以包含在请求中，一起发给服务器。这个值也只能设为true，如果服务器不要浏览器发送Cookie，删除该字段即可。
Access-Control-Allow-Credentials: true
Access-Control-Expose-Headers: FooBar
Content-Type: text/html; charset=utf-8
```
想要在CORS请求中发送cookie，则需要：
服务器：Access-Control-Allow-Credentials: true
浏览器xhr：var xhr = new XMLHttpRequest();     xhr.withCredentials = true;

> 需要注意的是，如果要发送Cookie，Access-Control-Allow-Origin就不能设为星号，必须指定明确的、与请求网页一致的域名。同时，Cookie依然遵循同源政策，只有用服务器域名设置的Cookie才会上传，其他域名的Cookie并不会上传，且（跨源）原网页代码中的document.cookie也无法读取服务器域名下的Cookie。

[参考文章](http://javascript.ruanyifeng.com/bom/same-origin.html)