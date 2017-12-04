# Document对象

这里只记录常用的属性和方法-。-

针对的是浏览器端的HTML网页

## 内部节点属性

- document.doctype：返回`<!DOCTYPE html>`（对于HTML5）
- document.documentElement：返回`html`节点
- document.defaultView：返回`window`对象
- document.body
- document.head

## 文档信息属性

### document.documentURI，document.URL
document.documentURI属性和document.URL属性都返回一个字符串，表示当前文档的网址。不同之处是documentURI属性可用于所有文档（包括 XML 文档），URL属性只能用于 HTML 文档。

### document.domain
document.domain属性返回当前文档的域名

### document.location
document.location属性返回location对象，提供了当前文档的URL信息。

### document.title
返回当前文档的标题，该属性是可写的。

### document.readyState
document.readyState属性返回当前文档的状态，共有三种可能的值。

- loading：加载HTML代码阶段（尚未完成解析）
- interactive：加载外部资源阶段时
- complete：加载完成时

### document.cookie
用来操作浏览器Cookie。

## 读写相关的方法

### document.write()
用于向当前文档写入内容。只要当前文档还没有用close方法关闭，它所写入的内容就会追加在已有内容的后面。

## 查找节点的方法

### document.querySelector()，document.querySelectorAll()
document.querySelector方法接受一个CSS选择器作为参数，返回匹配该选择器的元素节点。如果有多个节点满足匹配条件，则返回第一个匹配的节点。如果没有发现匹配的节点，则返回null。

document.querySelectorAll方法与querySelector用法类似，区别是返回一个NodeList对象，包含所有匹配给定选择器的节点。

### document.getElementsByTagName()

### document.getElementsByClassName()

### document.getElementsByName()

### getElementById()

## 生成节点的方法

### document.createElement()
用来生成网页元素节点，参数为元素的标签名，

### document.createTextNode()
用来生成文本节点，参数为所要生成的文本节点的内容。

### document.createAttribute()
生成一个新的属性对象节点，并返回它。

## 事件相关的方法

### document.createEvent()
生成一个事件对象，该对象可以被element.dispatchEvent方法使用，触发指定事件。

### document.addEventListener()，document.removeEventListener()，document.dispatchEvent()
```js
// 添加事件监听函数
document.addEventListener('click', listener, false);

// 移除事件监听函数
document.removeEventListener('click', listener, false);

// 触发事件
var event = new Event('click');
document.dispatchEvent(event);
```