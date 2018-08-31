# 函数
声明时注意，函数的表达式需要在语句的结尾加上分号，表示语句结束。而函数的声明在结尾的大括号后面不用加分号。

> js中只有函数内部会产生局部作用域。

## 函数的重复声明
如果同一个函数被多次声明，后面的声明就会覆盖前面的声明。

## 递归
函数可以调用自身，这就是递归（recursion）。

## 函数名的提升
JavaScript引擎将函数名视同变量名，所以采用function命令声明函数时，整个函数会像变量声明一样，被提升到代码头部。

采用赋值语句定义函数，不会提升。

注意：不能在条件语句中声明函数。

## 函数的属性和方法
### name属性
name属性返回紧跟在function关键字之后的那个函数名。
### length属性
length属性返回函数预期传入的参数个数，即函数定义之中的参数个数。
### toString()
函数的toString方法返回函数的源码。

## 传递方式
函数参数如果是原始类型的值（数值、字符串、布尔值），传递方式是传值传递（passes by value）。这意味着，在函数体内修改参数值，不会影响到函数外部。

但是，如果函数参数是复合类型的值（数组、对象、其他函数），传递方式是传址传递（pass by reference）。也就是说，传入函数的原始值的地址，因此在函数内部修改参数，将会影响到原始值。

## 参数默认值
通过下面的方法，可以为函数的参数设置默认值。
```js
function f(a){
  a = a || 1;
  return a;
}

f('') // 1
f(0) // 1
```
上面的函数中，不能让a等于0或空字符串，否则在明明有参数的情况下，也会返回默认值。

改进
```js
function f(a) {
  (a !== undefined && a !== null) ? a = a : a = 1;
  return a;
}

f() // 1
f('') // ""
f(0) // 0
```

## arguments

### 用处
```js
// 用于apply方法
myfunction.apply(obj, arguments).

// 使用与另一个数组合并
Array.prototype.concat.apply([1,2,3], arguments)
```

### 变为真正的数组
```js
Array.prototype.slice.call(arguments);

// or

var args = [];
for (var i = 0; i < arguments.length; i++) {
  args.push(arguments[i]);
}
```
### callee属性
arguments对象带有一个callee属性，返回它所对应的原函数。

## 闭包
如果出于种种原因，需要得到函数内的局部变量。正常情况下，这是办不到的，只有通过变通方法才能实现。那就是在函数的内部，再定义一个函数。

闭包的最大用处有两个，一个是可以读取函数内部的变量，另一个就是让这些变量始终保持在内存中，即闭包可以使得它诞生环境一直存在。请看下面的例子，闭包使得内部变量记住上一次调用时的运算结果。
```js
function createIncrementor(start) {
  return function () {
    return start++;
  };
}

var inc = createIncrementor(5);

inc() // 5
inc() // 6
inc() // 7
```
闭包的另一个用处，是封装对象的私有属性和私有方法。
```js
function Person(name) {
  var _age;
  function setAge(n) {
    _age = n;
  }
  function getAge() {
    return _age;
  }

  return {
    name: name,
    getAge: getAge,
    setAge: setAge
  };
}

var p1 = Person('张三');
p1.setAge(25);
p1.getAge() // 25
```
注意，外层函数每次运行，都会生成一个新的闭包，而这个闭包又会保留外层函数的内部变量，所以内存消耗很大。因此不能滥用闭包，否则会造成网页的性能问题。

## 立即调用的函数表达式
通常情况下，只对匿名函数使用这种“立即执行的函数表达式”。它的目的有两个：一是不必为函数命名，避免了污染全局变量；二是IIFE内部形成了一个单独的作用域，可以封装一些外部无法读取的私有变量。
```js
(function(){ /* code */ }());
// 或者
(function(){ /* code */ })();
```
## eval函数
将字符串当做语句执行
