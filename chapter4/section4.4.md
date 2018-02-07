# 事件模型

## EventTarget接口

- addEventListener：绑定事件的监听函数
- removeEventListener：移除事件的监听函数
- dispatchEvent：触发事件

### addEventListener
```js
// 使用格式
target.addEventListener(type, listener[, useCapture]);
// useCapture：布尔值，表示监听函数是否在捕获阶段（capture）触发（参见后文《事件的传播》部分），默认为false（监听函数只在冒泡阶段被触发）。老式浏览器规定该参数必写，较新版本的浏览器允许该参数可选。为了保持兼容，建议总是写上该参数。

function hello() {
  console.log('Hello world');
}

var button = document.getElementById('btn');
button.addEventListener('click', hello, false);

// 相同监听函数只执行一次
function hello() {
  console.log('Hello world');
}

document.addEventListener('click', hello, false);
document.addEventListener('click', hello, false);
```

### removeEventListener()

```js
div.addEventListener('click', listener, false);
div.removeEventListener('click', listener, false);
```

### dispatchEvent()
该方法返回一个布尔值，只要有一个监听函数调用了Event.preventDefault()，则返回值为false，否则为true。

```js
para.addEventListener('click', hello, false);
var event = new Event('click');
para.dispatchEvent(event);
```

**小结**

addEventListener是推荐的指定监听函数的方法。它有如下优点：

- 可以针对同一个事件，添加多个监听函数。

- 能够指定在哪个阶段（捕获阶段还是冒泡阶段）触发回监听函数。

- 除了DOM节点，还可以部署在window、XMLHttpRequest等对象上面，等于统一了整个JavaScript的监听函数接口。

### this

this对象都指向Element节点

```js
// JavaScript代码
element.onclick = print
element.addEventListener('click', print, false)
element.onclick = function () {console.log(this.id);}

// HTML代码
<element onclick="console.log(this.id)" id="el">
```

this指向全局对象

```js
function doSomething(){
  console.log(this.id);
}

// JavaScript代码
element.onclick = function (){ doSomething() };
element.setAttribute('onclick', 'doSomething()');

// HTML代码
<element onclick="doSomething()" id="el">
```

## 事件的传播

### 三个阶段

- 第一阶段：从window对象传导到目标节点，称为“捕获阶段”（capture phase）。

- 第二阶段：在目标节点上触发，称为“目标阶段”（target phase）。

- 第三阶段：从目标节点传导回window对象，称为“冒泡阶段”（bubbling phase）。

### 事件的代理
由于事件会在冒泡阶段向上传播到父节点，因此可以把子节点的监听函数定义在父节点上，由父节点的监听函数统一处理多个子元素的事件。这种方法叫做事件的代理（delegation）。

```js
var ul = document.querySelector('ul');

ul.addEventListener('click', function(event) {
  if (event.target.tagName.toLowerCase() === 'li') {
    // some code
  }
});
```

如果希望事件到某个节点为止，不再传播，可以使用事件对象的stopPropagation方法。

```js
p.addEventListener('click', function(event) {
  event.stopPropagation();
});
```

但是，stopPropagation方法只会阻止当前监听函数的传播，不会阻止<p>节点上的其他click事件的监听函数。如果想要不再触发那些监听函数，可以使用stopImmediatePropagation方法。

```js
p.addEventListener('click', function(event) {
 event.stopImmediatePropagation();
});

p.addEventListener('click', function(event) {
 // 不会被触发
});
```

## Event对象

兼容写法
```js
function myEventHandler(event) {
  var actualEvent = event || window.event;
  var actualTarget = actualEvent.target || actualEvent.srcElement;
  // ...
}
```
- event.target：事件最初发生的节点
- event.currentTarget：事件当前所在的节点
- event.preventDefault()
- event.stopPropagation()
- event.stopImmediatePropagation()：阻止同一个事件的其他监听函数被调用

## 自定义事件和事件模拟

```js
// 新建事件实例
var event = new Event('build');

// 添加监听函数
elem.addEventListener('build', function (e) { ... }, false);

// 触发事件
elem.dispatchEvent(event);
```

[参考文章](http://javascript.ruanyifeng.com/dom/event.html)