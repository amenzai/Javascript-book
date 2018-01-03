# Object对象

## Object()

Object本身当作工具方法使用时，可以将任意值转为对象。
```js
Object() // 返回一个空对象
Object() instanceof Object // true

Object(undefined) // 返回一个空对象
Object(undefined) instanceof Object // true

Object(null) // 返回一个空对象
Object(null) instanceof Object // true

Object(1) // 等同于 new Number(1)
Object(1) instanceof Object // true
Object(1) instanceof Number // true

Object('foo') // 等同于 new String('foo')
Object('foo') instanceof Object // true
Object('foo') instanceof String // true

Object(true) // 等同于 new Boolean(true)
Object(true) instanceof Object // true
Object(true) instanceof Boolean // true
```
如果Object方法的参数是一个对象，它总是返回原对象。
```js
var arr = [];
Object(arr) // 返回原数组
Object(arr) === arr // true

var obj = {};
Object(obj) // 返回原对象
Object(obj) === obj // true

var fn = function () {};
Object(fn) // 返回原函数
Object(fn) === fn // true
```

## 构造对象方法

### Object.keys()，Object.getOwnPropertyNames()
相同之处：

用来遍历对象的属性，参数都是一个对象，都返回一个数组，该数组的成员都是对象自身的（而不是继承的）所有属性名。

不同之处：

Object.keys方法只返回可枚举的属性，Object.getOwnPropertyNames方法还返回不可枚举的属性名（比如数组的length属性）。

一般情况下，几乎总是使用Object.keys方法，遍历数组的属性。

### Object.values() Object.entries()
Object.values()遍历对象的值，返回一个数组。

Object.entries()遍历对象的键值，返回一个二维数组。


## 原型对象方法

- valueOf()：返回当前对象对应的值。
- toString()：返回当前对象对应的字符串形式。
- toLocaleString()：返回当前对象对应的本地字符串形式。
- hasOwnProperty()：判断某个属性是否为当前对象自身的属性，还是继承自原型对象的属性。
- isPrototypeOf()：判断当前对象是否为另一个对象的原型。
- propertyIsEnumerable()：判断某个属性是否可枚举。

### Object.prototype.valueOf()
```js
var o = new Object();
o.valueOf() === o // true
```

### Object.prototype.toString()
```js
var o1 = new Object();
o1.toString() // "[object Object]"

var o2 = {a:1};
o2.toString() // "[object Object]"
```


