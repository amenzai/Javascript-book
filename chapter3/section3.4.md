# Object对象的相关方法

通过原型链，对象的属性分成两种：自身的属性和继承的属性。JavaScript 语言在Object对象上面，提供了很多相关方法，来处理这两种不同的属性。

## Object.getPrototypeOf()
Object.getPrototypeOf方法返回参数对象的原型。这是获取原型对象的标准方法。

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
Object.setPrototypeOf方法可以为参数对象设置原型，返回一个新对象。

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

```js
var obj = Object.create({}, {
  p1: {
    value: 123,
    enumerable: true,
    configurable: true,
    writable: true,
  },
  p2: {
    value: 'abc',
    enumerable: true,
    configurable: true,
    writable: true,
  }
});

// 等同于
var obj = Object.create({});
obj.p1 = 123;
obj.p2 = 'abc';
```

## Object.prototype.isPrototypeOf()
对象实例的isPrototypeOf方法，用来判断一个对象是否是另一个对象的原型。

只要某个对象处在原型链上，isPrototypeOf都返回true。

## Object.prototype.__proto__ 
实例对象的__proto__属性（前后各两个下划线），返回该对象的原型。该属性可读写。

## Object.getOwnPropertyNames()
返回一个数组，成员是对象本身的所有属性的键名，不包含继承的属性键名。

Object.getOwnPropertyNames方法返回所有键名。只获取那些可以枚举的属性，使用Object.keys方法。

```js
Object.getOwnPropertyNames(Date)
// ["parse", "arguments", "UTC", "caller", "name", "prototype", "now", "length"]

Object.keys(Date) // []
```

## Object.prototype.hasOwnProperty()
对象实例的hasOwnProperty方法返回一个布尔值，用于判断某个属性定义在对象自身，还是定义在原型链上。
```js
Date.hasOwnProperty('length')
// true

Date.hasOwnProperty('toString')
// false
```

## in 运算符和 for…in 循环
in运算符返回一个布尔值，表示一个对象是否具有某个属性。它不区分该属性是对象自身的属性，还是继承的属性。

获得对象的所有可枚举属性（不管是自身的还是继承的），可以使用for...in循环。

```js
var o1 = {p1: 123};

var o2 = Object.create(o1, {
  p2: { value: "abc", enumerable: true }
});

for (p in o2) {console.info(p);}
// p2
// p1
```

## 对象的拷贝
如果要拷贝一个对象，需要做到下面两件事情。

- 确保拷贝后的对象，与原对象具有同样的prototype原型对象。
- 确保拷贝后的对象，与原对象具有同样的属性。

```js
// 对象拷贝函数
function copyObject(orig) {
  var copy = Object.create(Object.getPrototypeOf(orig));
  copyOwnPropertiesFrom(copy, orig);
  return copy;
}

function copyOwnPropertiesFrom(target, source) {
  Object
  .getOwnPropertyNames(source)
  .forEach(function(propKey) {
    var desc = Object.getOwnPropertyDescriptor(source, propKey);
    Object.defineProperty(target, propKey, desc);
  });
  return target;
}

// or
function copyObject(orig) {
  return Object.create(
    Object.getPrototypeOf(orig),
    Object.getOwnPropertyDescriptors(orig)
  );
}
```