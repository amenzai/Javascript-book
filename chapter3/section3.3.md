# prototype 对象

## 作用
定义所有实例对象共享的属性和方法。

## 原型链
对象的原型最终都可以上溯到Object.prototype，即Object构造函数的prototype属性。

Object.prototype对象的原型是null，由于null没有任何属性，所以原型链到此为止。

## constructor 属性
prototype对象有一个constructor属性，默认指向prototype对象所在的构造函数。

constructor属性的作用，是分辨原型对象到底属于哪个构造函数。

## instanceof 运算符
instanceof运算符返回一个布尔值，表示某个对象是否为指定的构造函数的实例。

instanceof运算符的左边是实例对象，右边是构造函数。它会检查右边构建函数的原型对象（prototype），是否在左边对象的原型链上。因此，下面两种写法是等价的。

```js
v instanceof Vehicle
// 等同于
Vehicle.prototype.isPrototypeOf(v)
```

## Object.getPrototypeOf()
Object.getPrototypeOf方法返回一个对象的原型。这是获取原型对象的标准方法。

```js
// 空对象的原型是Object.prototype
Object.getPrototypeOf({}) === Object.prototype
// true

// 函数的原型是Function.prototype
function f() {}
Object.getPrototypeOf(f) === Function.prototype
// true

// f 为 F 的实例对象，则 f 的原型是 F.prototype
var f = new F();
Object.getPrototypeOf(f) === F.prototype
// true
```

## Object.setPrototypeOf()
Object.setPrototypeOf方法可以为现有对象设置原型，返回一个新对象。

Object.setPrototypeOf方法接受两个参数，第一个是现有对象，第二个是原型对象。

```js
var a = {x: 1};
var b = Object.setPrototypeOf({}, a);
// 等同于
// var b = {__proto__: a};

b.x // 1
```

## Object.create()
该方法接受一个对象作为参数，然后以它为原型，返回一个实例对象。该实例完全继承原型对象的属性。

object.create方法生成的新对象，动态继承了原型。在原型上添加或修改任何方法，会立刻反映在新对象之上。

除了对象的原型，Object.create方法还可以接受第二个参数。该参数是一个属性描述对象，它所描述的对象属性，会添加到实例对象，作为该对象自身的属性。

## Object.prototype.isPrototypeOf()
对象实例的isPrototypeOf方法，用来判断一个对象是否是另一个对象的原型。

只要某个对象处在原型链上，isPrototypeOf都返回true。