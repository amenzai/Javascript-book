# Object对象

通过原型链，对象的属性分成两种：自身的属性和继承的属性。JavaScript 语言在Object对象上面，提供了很多相关方法，来处理这两种不同的属性。

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
## 其他常用方法
- Object.getPrototypeOf()
返回参数对象的原型。
- Object.setPrototypeOf()
为参数对象设置原型，返回该参数对象。它接受两个参数，第一个是现有对象，第二个是原型对象。
- Object.create()
该方法接受一个对象作为参数，然后以它为原型，返回一个实例对象。该实例完全继承原型对象的属性。
- Object.prototype.isPrototypeOf()
判断该对象是否为参数对象的原型
- Object.prototype.__proto__()
返回该对象的原型，属性可读写。