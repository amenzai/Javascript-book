# this简介

## 含义
this总是返回一个对象，简单说，就是返回属性或方法“当前”所在的对象。

可以近似地认为，this是所有函数运行时的一个隐藏参数，指向函数的运行环境。

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

### 避免数组处理方法中的this
数组的map和foreach方法，允许提供一个函数作为参数。这个函数内部不应该使用this。

### 避免回调函数中的this
回调函数中的this往往会改变指向，最好避免使用。

## 绑定 this 的方法

### function.prototype.call()
函数实例的call方法，可以指定函数内部this的指向（即函数执行时所在的作用域），然后在所指定的作用域中，调用该函数。

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