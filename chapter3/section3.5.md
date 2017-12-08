# 面向对象编程

## 构造函数的继承
让一个构造函数继承另一个构造函数，是非常常见的需求。

这可以分成两步实现。第一步是在子类的构造函数中，调用父类的构造函数。

```js
function Sub(value) {
  // this是子类实例
  Super.call(this);
  this.prop = value;
}
```

第二步，是让子类的原型指向父类的原型，这样子类就可以继承父类原型。

```js
Sub.prototype = Object.create(Super.prototype);
Sub.prototype.constructor = Sub;
Sub.prototype.method = '...';
```
另外一种写法是Sub.prototype等于一个父类实例。

## 多重继承

```js
function M1() {
  this.hello = 'hello';
}

function M2() {
  this.world = 'world';
}

function S() {
  M1.call(this);
  M2.call(this);
}

// 继承 M1
S.prototype = Object.create(M1.prototype);
// 继承链上加入 M2
Object.assign(S.prototype, M2.prototype);

// 指定构造函数
S.prototype.constructor = S;

var s = new S();
s.hello // 'hello：'
s.world // 'world'
``` 
上面代码中，子类S同时继承了父类M1和M2。

## 模块

### 基本的实现方法

```js
var module1 = {
  count: 0,
  m1: function() {

  } 
}
module1.m1()
```
有个问题，外部代码可以直接改变内部计数器的值。
```js
module1.count = 10;
```

### 封装私有变量
```js
var module1 = (function () {
　var _count = 0;
　var m1 = function () {
　  //...
　};
　var m2 = function () {
　　//...
　};
　return {
　　m1 : m1,
　　m2 : m2
　};
})();
```

### 推荐写法

```js
(function($, window, document) {

  function go(num) {
  }

  function handleEvents() {
  }

  function initialize() {
  }

  function dieCarouselDie() {
  }

  //attach to the global scope
  window.finalCarousel = {
    init : initialize,
    destroy : dieCouraselDie
  }

})( jQuery, window, document );
``` 

