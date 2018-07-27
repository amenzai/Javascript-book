# 属性描述对象

## 概要

属性描述对象提供6个元属性。

（1）value

value是该属性的属性值，默认为undefined。

（2）writable

writable是一个布尔值，表示属性值（value）是否可改变（即是否可写），默认为true。

（3）enumerable

enumerable是一个布尔值，表示该属性是否可遍历，默认为true。如果设为false，会使得某些操作（比如for...in循环、Object.keys()）跳过该属性。

（4）configurable

configurable是一个布尔值，表示可配置性，默认为true。如果设为false，将阻止某些操作改写该属性，比如无法删除该属性，也不得改变该属性的属性描述对象（value属性除外）。也就是说，configurable属性控制了属性描述对象的可写性。

（5）get

get是一个函数，表示该属性的取值函数（getter），默认为undefined。

（6）set

set是一个函数，表示该属性的存值函数（setter），默认为undefined。

## Object.getOwnPropertyDescriptor()

```js
var obj = { p: 'a' };

Object.getOwnPropertyDescriptor(obj, 'p')
// Object { value: "a",
//   writable: true,
//   enumerable: true,
//   configurable: true
// }
```
注意，Object.getOwnPropertyDescriptor方法只能用于对象自身的属性，不能用于继承的属性。

## Object.getOwnPropertyNames() 
返回一个数组，成员是参数对象自身的全部属性的属性名，不管该属性是否可遍历。
```js
var obj = Object.defineProperties({}, {
  p1: { value: 1, enumerable: true },
  p2: { value: 2, enumerable: false }
});

Object.getOwnPropertyNames(obj)
// ["p1", "p2"]
```

## Object.defineProperty()，Object.defineProperties()
```js
// use
Object.defineProperty(object, propertyName, attributesObject)

var obj = Object.defineProperty({}, 'p', {
  value: 123,
  writable: false,
  enumerable: true,
  configurable: false
});

obj.p // 123

obj.p = 246;
obj.p // 123
```

如果一次性定义或修改多个属性，可以使用Object.defineProperties方法。

```js
var obj = Object.defineProperties({}, {
  p1: { value: 123, enumerable: true },
  p2: { value: 'abc', enumerable: true },
  p3: { get: function () { return this.p1 + this.p2 },
    enumerable:true,
    configurable:true
  }
});

obj.p1 // 123
obj.p2 // "abc"
obj.p3 // "123abc"
```
注意，一旦定义了取值函数get（或存值函数set），就不能将writable属性设为true，或者同时定义value属性，否则会报错。

Object.defineProperty()和Object.defineProperties()的第三个参数，是一个属性对象。它的writable、configurable、enumerable这三个属性的默认值都为false。

```js
var obj = {};
Object.defineProperty(obj, 'foo', {});
Object.getOwnPropertyDescriptor(obj, 'foo')
// {
//   value: undefined,
//   writable: false,
//   enumerable: false,
//   configurable: false
// }
```

## Object.prototype.propertyIsEnumerable()

实例对象的propertyIsEnumerable方法返回一个布尔值，用来判断某个属性是否可遍历。

## 存取器

存取器往往用于，属性的值依赖对象内部数据的场合。

```js

var obj = Object.defineProperty({}, 'p', {
  get: function () {
    return 'getter';
  },
  set: function (value) {
    console.log('setter: ' + value);
  }
});

obj.p // "getter"
obj.p = 123 // "setter: 123"

// 另一种写法
var obj ={
  $n : 5,
  get next() { return this.$n++ },
  set next(n) {
    if (n >= this.$n) this.$n = n;
    else throw new Error('新的值必须大于当前值');
  }
};

obj.next // 5

obj.next = 10;
obj.next // 10

obj.next = 5;
// Uncaught Error: 新的值必须大于当前值
```

## 对象的拷贝

```js
var extend = function (to, from) {
  for (var property in from) {
    if (!from.hasOwnProperty(property)) continue;
    Object.defineProperty(
      to,
      property,
      Object.getOwnPropertyDescriptor(from, property)
    );
  }

  return to;
}

extend({}, { get a(){ return 1 } })
// { get a(){ return 1 } })
```

## 控制对象状态
有时需要冻结对象的读写状态，防止对象被改变。JavaScript 提供了三种冻结方法，最弱的一种是Object.preventExtensions，其次是Object.seal，最强的是Object.freeze。
### Object.preventExtensions()
无法再添加新的属性

```js
var obj = new Object();
Object.preventExtensions(obj);

Object.defineProperty(obj, 'p', {
  value: 'hello'
});
// TypeError: Cannot define property:p, object is not extensible.

obj.p = 1;
obj.p // undefined
```

### Object.isExtensible()

检查一个对象是否使用了Object.preventExtensions方法。也就是说，检查是否可以为一个对象添加属性。

```js
var obj = new Object();

Object.isExtensible(obj) // true
Object.preventExtensions(obj);
Object.isExtensible(obj) // false
```

### Object.seal()

使得一个对象既无法添加新属性，也无法删除旧属性。

```js
var obj = { p: 'hello' };
Object.seal(obj);

delete obj.p;
obj.p // "hello"

obj.x = 'world';
obj.x // undefined
```
Object.seal实质是把属性描述对象的configurable属性设为false，因此属性描述对象不再能改变了。

### Object.isSealed()
检查一个对象是否使用了Object.seal方法。

```js
var obj = { p: 'a' };

Object.seal(obj);
Object.isSealed(obj) // true
Object.isExtensible(obj) // false
```

### Object.freeze()
Object.freeze方法可以使得一个对象无法添加新属性、无法删除旧属性、也无法改变属性的值，使得这个对象实际上变成了常量。

```js
var obj = {
  p: 'hello'
};

Object.freeze(obj);

obj.p = 'world';
obj.p // "hello"

obj.t = 'hello';
obj.t // undefined

delete obj.p // false
obj.p // "hello"
```

### Object.isFrozen()

检查一个对象是否使用了Object.freeze方法。

```js
var obj = {
  p: 'hello'
};

Object.freeze(obj);
Object.isFrozen(obj) // true
```

[参考文章](http://javascript.ruanyifeng.com/stdlib/attributes.html)