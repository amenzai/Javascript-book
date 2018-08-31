# <a>元素

## 属性
### URL 相关属性

`<a>`元素有一系列 URL 相关属性，可以用来操作链接地址。这些属性的含义，可以参见Location对象的实例属性。

- hash：片段识别符（以#开头）
- host：主机和端口（默认端口80和443会省略）
- hostname：主机名
- href：完整的 URL
- origin：协议、域名和端口
- password：主机名前的密码
- pathname：路径（以/开头）
- port：端口
- protocol：协议（包含尾部的冒号:）
- search：查询字符串（以?开头）
- username：主机名前的用户名
```js
// HTML 代码如下
// <a id="test" href="http://user:passed@example.com:8081/index.html?bar=1#foo">test</a>
var a = document.getElementById('test');
a.hash // "#foo"
a.host // "example.com:8081"
a.hostname // "example.com"
a.href // "http://user:passed@example.com:8081/index.html?bar=1#foo"
a.origin // "http://example.com:8081"
a.password // "passwd"
a.pathname // "/index.html"
a.port // "8081"
a.protocol // "http:"
a.search // "?bar=1"
a.username // "user"
```
除了origin属性是只读的，上面这些属性都是可读写的。

### accessKey 属性

accessKey属性用来读写`<a>`元素的快捷键。

```js
// HTML 代码如下
// <a id="test" href="http://example.com">test</a>
var a = document.getElementById('a');
a.accessKey = 'k';
```
上面代码设置`<a>`元素的快捷键为k，以后只要按下这个快捷键，浏览器就会跳转到example.com。

注意，不同的浏览器在不同的操作系统下，唤起快捷键的功能键组合是不一样的。比如，Chrome 浏览器在 Linux 系统下，需要按下Alt + k，才会跳转到example.com。

### download 属性
download属性表示当前链接不是用来浏览，而是用来下载的。它的值是一个字符串，表示用户下载得到的文件名。
```js
// HTML 代码如下
// <a id="test" href="foo.jpg">下载</a>
var a = document.getElementById('test');
a.download = 'bar.jpg';
```
上面代码中，`<a>`元素是一个图片链接，默认情况下，点击后图片会在当前窗口加载。设置了download属性以后，再点击这个链接，就会下载对话框，询问用户保存位置，而且下载的文件名为bar.jpg。

### hreflang 属性
hreflang属性用来读写`<a>`元素的 HTML 属性hreflang，表示链接指向的资源的语言，比如hreflang="en"。
```js
// HTML 代码如下
// <a id="test" href="https://example.com" hreflang="en">test</a>
var a = document.getElementById('test');
a.hreflang // "en"
```

### referrerPolicy 属性
referrerPolicy属性用来读写`<a>`元素的 HTML 属性referrerPolicy，指定当用户点击链接时，如何发送 HTTP 头信息的referer字段。

HTTP 头信息的referer字段，表示当前请求是从哪里来的。它的格式可以由`<a>`元素的referrerPolicy属性指定，共有三个值可以选择。

- no-referrer：不发送referer字段。
- origin：referer字段的值是`<a>`元素的origin属性，即协议 + 主机名 + 端口。
- unsafe-url：referer字段的值是origin属性再加上路径，但不包含#片段。这种格式提供的信息最详细，可能存在信息泄漏的风险。
```js
// HTML 代码如下
// <a id="test" href="https://example.com" referrerpolicy="no-referrer">test</a>
var a = document.getElementById('test');
a.referrerPolicy // "no-referrer"
```
### rel 属性
rel属性用来读写`<a>`元素的 HTML 属性rel，表示链接与当前文档的关系。

```js
// HTML 代码如下
// <a id="test" href="https://example.com" rel="license">license.html</a>
var a = document.getElementById('test');
a.rel // "license"
```
### tabIndex 属性
tabIndex属性的值是一个整数，用来读写当前`<a>`元素在文档里面的 Tab 键遍历顺序。
```js
// HTML 代码如下
// <a id="test" href="https://example.com">test</a>
var a = document.getElementById('test');
a.tabIndex // 0
```
### target 属性
target属性用来读写`<a>`元素的 HTML 属性target。

```js
// HTML 代码如下
// <a id="test" href="https://example.com" target="_blank">test</a>
var a = document.getElementById('test');
a.target // "_blank"
```
### text 属性
text属性用来读写`<a>`元素的链接文本，等同于当前节点的textContent属性。

```js
// HTML 代码如下
// <a id="test" href="https://example.com">test</a>
var a = document.getElementById('test');
a.text // "test"
```
### type 属性
type属性用来读写`<a>`元素的 HTML 属性type，表示链接目标的 MIME 类型。
```js
// HTML 代码如下
// <a id="test" type="video/mp4" href="example.mp4">video</a>
var a = document.getElementById('test');
a.type // "video/mp4"
```
## 方法
`<a>`元素的方法都是继承的，主要有以下三个。

- blur()：从当前元素移除键盘焦点，详见HTMLElement接口的介绍。
- focus()：当前元素得到键盘焦点，详见HTMLElement接口的介绍。
- toString()：返回当前`<a>`元素的 HTML 属性href。