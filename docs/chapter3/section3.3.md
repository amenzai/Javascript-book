# 对象的继承

## 概述

### 构造函数缺点

通过构造函数为实例对象定义属性，虽然很方便，但是有一个缺点。同一个构造函数的多个实例之间，无法共享属性，从而造成对系统资源的浪费。

```js
function Cat(name, color) {
  this.name = name;
  this.color = color;
  this.meow = function () {
    console.log('喵喵');
  };
}

var cat1 = new Cat('大毛', '白色');
var cat2 = new Cat('二毛', '黑色');

cat1.meow === cat2.meow
// false
```
上面代码中，cat1和cat2是同一个构造函数的两个实例，它们都具有meow方法。由于meow方法是生成在每个实例对象上面，所以两个实例就生成了两次。也就是说，每新建一个实例，就会新建一个meow方法。这既没有必要，又浪费系统资源，因为所有meow方法都是同样的行为，完全应该共享。

这个问题的解决方法，就是 JavaScript 的原型对象（prototype）。

### prototype 属性的作用
定义所有实例对象共享的属性和方法。

### 原型链
JavaScript 规定，所有对象都有自己的原型对象（prototype）。一方面，任何一个对象，都可以充当其他对象的原型；另一方面，由于原型对象也是对象，所以它也有自己的原型。因此，就会形成一个“原型链”（prototype chain）：对象到原型，再到原型的原型……

对象的原型最终都可以上溯到Object.prototype，即Object构造函数的prototype属性。

Object.prototype对象的原型是null，由于null没有任何属性，所以原型链到此为止。

### constructor 属性
prototype对象有一个constructor属性，默认指向prototype对象所在的构造函数。

constructor属性的作用，是分辨原型对象到底属于哪个构造函数。

### instanceof 运算符
instanceof运算符返回一个布尔值，表示某个对象是否为指定的构造函数的实例。

instanceof运算符的左边是实例对象，右边是构造函数。它会检查右边构建函数的原型对象（prototype），是否在左边对象的原型链上。因此，下面两种写法是等价的。

```js
v instanceof Vehicle
// 等同于
Vehicle.prototype.isPrototypeOf(v)
```

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
```js
Sub.prototype = new Super();
```
上面这种写法也有继承的效果，但是子类会具有父类实例的方法。有时，这可能不是我们需要的，所以不推荐使用这种写法。

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