# Cookie

Cookie 是服务器保存在浏览器的一小段文本信息，每个 Cookie 的大小一般不能超过4KB。浏览器每次向服务器发出请求，就会自动附上这段信息。

window.navigator.cookieEnabled属性返回一个布尔值，表示浏览器是否打开 Cookie 功能。

document.cookie一次只能写入一个 Cookie，而且写入并不是覆盖，而是添加。
```js
document.cookie = 'test1=hello';
document.cookie = 'test2=world';
document.cookie
```
浏览器向服务器发送 Cookie 的时候，是使用一行将所有 Cookie 全部发送。
```js
GET /sample_page.html HTTP/1.1
Host: www.example.org
Cookie: cookie_name1=cookie_value1; cookie_name2=cookie_value2
Accept: */*
```
服务器告诉浏览器需要储存 Cookie 的时候，则是分行指定。
```js
HTTP/1.0 200 OK
Content-type: text/html
Set-Cookie: cookie_name1=cookie_value1
Set-Cookie: cookie_name2=cookie_value2; expires=Sun, 16 Jul 3567 06:23:41 GMT
```

服务器向浏览器发送 Cookie 的时候，除了 Cookie 本身的内容，还有一些可选的属性也是可以写入的，它们都必须以分号开头。
```js
Set-Cookie: value[; expires=date][; domain=domain][; path=path][; secure]
```
浏览器根据本地时间，决定 Cookie 是否过期，由于本地时间是不精确的，所以没有办法保证 Cookie 一定会在服务器指定的时间过期。
max-age属性用来指定Cookie有效期，比如60 * 60 * 24 * 365（即一年31536e3秒）。
HttpOnly属性用于设置该Cookie不能被JavaScript读取
```js
Set-Cookie: key=value; HttpOnly
```

删除一个 Cookie 的唯一方法是设置其expires为一个过去的日期。
```js
document.cookie = 'fontSize=;expires=Thu, 01-Jan-1970 00:00:01 GMT';
```
数量的限制:
Firefox 是每个域名最多设置50个 Cookie，而 Safari 和 Chrome 没有域名数量的限制。
所有 Cookie 的累加长度限制为4KB。超过这个长度的 Cookie，将被忽略，不会被设置。

同源政策:
浏览器的同源政策规定，两个网址只要域名相同和端口相同，就可以共享 Cookie。不要求协议相同

[参考文章](http://javascript.ruanyifeng.com/bom/cookie.html)