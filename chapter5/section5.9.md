# SSE：服务器发送事件

SSE，就是浏览器向服务器发送一个HTTP请求，然后服务器不断单向地向浏览器推送“信息”（message）。这种信息在格式上很简单，就是“信息”加上前缀“data: ”，然后以“\n\n”结尾。

```js
$ curl http://example.com/dates
data: 1394572346452

data: 1394572347457

data: 1394572348463

^C
```

**使用：**

```js
// 检查浏览器是否支持
if (!!window.EventSource) {
  // ...
}

// 向服务器发起连接 参数url就是服务器网址，必须与当前网页的网址在同一个网域（domain），而且协议和端口都必须相同。
var source = new EventSource('/dates');  

source.onmessage = function(e){
  console.log(e.data);
};

source.addEventListener("open", function(event) {
  // handle open event
}, false);

// event有以下属性
// data：服务器端传回的数据（文本格式）。
// origin： 服务器端URL的域名部分，即协议、域名和端口。
// lastEventId：数据的编号，由服务器端发送。如果没有编号，这个属性为空。
source.addEventListener("message", function(event) {
  var data = event.data;
  var origin = event.origin;
  var lastEventId = event.lastEventId;
  // handle message
}, false);

source.addEventListener("error", function(event) {
  // handle error event
}, false);
```

[详情参考](https://www.kancloud.cn/kancloud/javascript-standards-reference/46466)