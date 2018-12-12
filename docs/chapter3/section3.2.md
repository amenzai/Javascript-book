# this简介

## 含义
this总是返回一个对象，简单说，就是返回属性或方法“当前”所在的对象。

可以近似地认为，this是所有函数运行时的一个隐藏参数，指向函数的运行环境。

总结一下，JavaScript 语言之中，一切皆对象，运行环境也是对象，所以函数都是在某个对象之中运行，this就是函数运行时所在的对象（环境）。这本来并不会让用户糊涂，但是 JavaScript 支持运行环境动态切换，也就是说，this的指向是动态的，没有办法事先确定到底指向哪个对象，这才是最让初学者感到困惑的地方。

## 实质

JavaScript 语言之所以有 this 的设计，跟内存里面的数据结构有关系。
```js
var obj = { foo:  5 };
```
上面的代码将一个对象赋值给变量obj。JavaScript 引擎会先在内存里面，生成一个对象{ foo: 5 }，然后把这个对象的内存地址赋值给变量obj。也就是说，变量obj是一个地址（reference）。后面如果要读取obj.foo，引擎先从obj拿到内存地址，然后再从该地址读出原始的对象，返回它的foo属性。

原始的对象以字典结构保存，每一个属性名都对应一个属性描述对象。举例来说，上面例子的foo属性，实际上是以下面的形式保存的。
```js
{
  foo: {
    [[value]]: 5
    [[writable]]: true
    [[enumerable]]: true
    [[configurable]]: true
  }
}
```
注意，foo属性的值保存在属性描述对象的value属性里面。

这样的结构是很清晰的，问题在于属性的值可能是一个函数。
```js
var obj = { foo: function () {} };
```
这时，引擎会将函数单独保存在内存中，然后再将函数的地址赋值给foo属性的value属性。
```js
{
  foo: {
    [[value]]: 函数的地址
    ...
  }
}
```
由于函数是一个单独的值，所以它可以在不同的环境（上下文）执行。
```js
var f = function () {};
var obj = { f: f };

// 单独执行
f()

// obj 环境执行
obj.f()
```
JavaScript 允许在函数体内部，引用当前环境的其他变量。
```js
var f = function () {
  console.log(x);
};
```
上面代码中，函数体里面使用了变量x。该变量由运行环境提供。

现在问题就来了，由于函数可以在不同的运行环境执行，所以需要有一种机制，能够在函数体内部获得当前的运行环境（context）。所以，this就出现了，它的设计目的就是在函数体内部，指代函数当前的运行环境。
```js
var f = function () {
  console.log(this.x);
}
```
上面代码中，函数体里面的this.x就是指当前运行环境的x。
```js
var f = function () {
  console.log(this.x);
}

var x = 1;
var obj = {
  f: f,
  x: 2,
};

// 单独执行
f() // 1

// obj 环境执行
obj.f() // 2
```
上面代码中，函数f在全局环境执行，this.x指向全局环境的x；在obj环境执行，this.x指向obj.x。

## 使用场合

### 全局环境
在全局环境使用this，它指的就是顶层对象window。

### 构造函数
构造函数中的this，指的是实例对象。

### 对象的方法
当 A 对象的方法被赋予 B 对象，该方法中的this就从指向 A 对象变成了指向 B 对象。所以要特别小心，将某个对象的方法赋值给另一个对象，会改变this的指向。

## 使用注意点

### 避免多层 this
由于this的指向是不确定的，所以切勿在函数中包含多层的this。

严格模式下，如果函数内部的this指向顶层对象，就会报错。

### 避免数组处理方法中的this
数组的map和foreach方法，允许提供一个函数作为参数。这个函数内部不应该使用this。

### 避免回调函数中的this
回调函数中的this往往会改变指向，最好避免使用。

## 绑定 this 的方法

### function.prototype.call()
函数实例的call方法，可以指定函数内部this的指向（即函数执行时所在的作用域），然后在所指定的作用域中，调用该函数。

call方法的参数，应该是一个对象。如果参数为空、null和undefined，则默认传入全局对象。

```js
func.call(thisValue, arg1, arg2, ...)
```

### function.prototype.apply()
apply方法的作用与call方法类似，也是改变this指向，然后再调用该函数。唯一的区别就是，它接收一个数组作为函数执行时的参数，使用格式如下。

```js
func.apply(thisValue, [arg1, arg2, ...])
```

用处：

```js
// 找出数组最大值
var a = [10, 2, 4, 15, 9];

Math.max.apply(null, a)
// 15

// 将数组的空元素变为undefined
Array.apply(null, ["a",,"b"])
// [ 'a', undefined, 'b' ]

// 转换类似数组的对象
Array.prototype.slice.apply({0:1,length:1})
// [1]

Array.prototype.slice.apply({0:1})
// []

Array.prototype.slice.apply({0:1,length:2})
// [1, undefined]

Array.prototype.slice.apply({length:1})
// [undefined]
```

### function.prototype.bind()
bind方法用于将函数体内的this绑定到某个对象，然后返回一个新函数。

```js
var listener = o.m.bind(o);
element.addEventListener('click', listener);
//  ...
element.removeEventListener('click', listener);
```