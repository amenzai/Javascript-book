# 严格模式

## 显式报错
严格模式使得 JavaScript 的语法变得更严格，更多的操作会显式报错。其中有些操作，在正常模式下只会默默地失败，不会报错。

### 只读属性不可写

严格模式下，设置字符串的length属性，会报错。

严格模式下，对只读属性赋值，或者删除不可配置（non-configurable）属性都会报错。
```js
// 对只读属性赋值会报错
'use strict';
Object.defineProperty({}, 'a', {
  value: 37,
  writable: false
});
obj.a = 123;
// TypeError: Cannot assign to read only property 'a' of object #<Object>

// 删除不可配置的属性会报错
'use strict';
var obj = Object.defineProperty({}, 'p', {
  value: 1,
  configurable: false
});
delete obj.p
// TypeError: Cannot delete property 'p' of #<Object>
```

### 只设置了取值器的属性不可写
严格模式下，对一个只有取值器（getter）、没有存值器（setter）的属性赋值，会报错。
```js
'use strict';
var obj = {
  get v() { return 1; }
};
obj.v = 2;
// Uncaught TypeError: Cannot set property v of #<Object> which has only a getter
```

### 禁止扩展的对象不可扩展
```js
'use strict';
var obj = {};
Object.preventExtensions(obj);
obj.v = 1;
// Uncaught TypeError: Cannot add property v, object is not extensible
```
### eval、arguments 不可用作标识名

```js
'use strict';
var eval = 17;
var arguments = 17;
var obj = { set p(arguments) { } };
try { } catch (arguments) { }
function x(eval) { }
function arguments() { }
var y = function eval() { };
var f = new Function('arguments', "'use strict'; return 17;");
// SyntaxError: Unexpected eval or arguments in strict mode
```

### 函数不能有重名的参数
正常模式下，如果函数有多个重名的参数，可以用arguments[i]读取。严格模式下，这属于语法错误。

### 禁止八进制的前缀0表示法
正常模式下，整数的第一位如果是0，表示这是八进制数，比如0100等于十进制的64。严格模式禁止这种表示法，整数第一位为0，将报错。

## 增强的安全措施

### 全局变量显式声明
正常模式中，如果一个变量没有声明就赋值，默认是全局变量。严格模式禁止这种用法，全局变量必须显式声明。

### 禁止 this 关键字指向全局对象
正常模式下，函数内部的this可能会指向全局对象，严格模式禁止这种用法，避免无意间创造全局变量。
```js
// 正常模式
function f() {
  console.log(this === window);
}
f() // true

// 严格模式
function f() {
  'use strict';
  console.log(this === undefined);
}
f() // true
```

```js
// 正常模式
function fun() {
  return this;
}

fun() // window
fun.call(2) // Number {2}
fun.call(true) // Boolean {true}
fun.call(null) // window
fun.call(undefined) // window

// 严格模式
'use strict';
function fun() {
  return this;
}

fun() //undefined
fun.call(2) // 2
fun.call(true) // true
fun.call(null) // null
fun.call(undefined) // undefined
```

上面代码中，可以把任意类型的值，绑定在this上面。

### 禁止使用 fn.callee、fn.caller
函数内部不得使用fn.caller、fn.arguments，否则会报错。这意味着不能在函数内部得到调用栈了。

### 禁止使用 arguments.callee、arguments.caller
arguments.callee和arguments.caller是两个历史遗留的变量，从来没有标准化过，现在已经取消了。正常模式下调用它们没有什么作用，但是不会报错。严格模式明确规定，函数内部使用arguments.callee、arguments.caller将会报错。

### 禁止删除变量
严格模式下无法删除变量，如果使用delete命令删除一个变量，会报错。只有对象的属性，且属性的描述对象的configurable属性设置为true，才能被delete命令删除。

## 静态绑定

### 禁止使用 with 语句 
严格模式下，使用with语句将报错。因为with语句无法在编译时就确定，某个属性到底归属哪个对象，从而影响了编译效果。

### 创设 eval 作用域
正常模式下，JavaScript 语言有两种变量作用域（scope）：全局作用域和函数作用域。严格模式创设了第三种作用域：eval作用域。

正常模式下，eval语句的作用域，取决于它处于全局作用域，还是函数作用域。严格模式下，eval语句本身就是一个作用域，不再能够在其所运行的作用域创设新的变量了，也就是说，eval所生成的变量只能用于eval内部。

### arguments 不再追踪参数的变化 
变量arguments代表函数的参数。严格模式下，函数内部改变参数与arguments的联系被切断了，两者不再存在联动关系。

```js
function f(a) {
  a = 2;
  return [a, arguments[0]];
}
f(1); // 正常模式为[2, 2]

function f(a) {
  'use strict';
  a = 2;
  return [a, arguments[0]];
}
f(1); // 严格模式为[2, 1]
```

## 向下一个版本的 JavaScript 过渡
### 非函数代码块不得声明函数
ES6 会引入块级作用域。为了与新版本接轨，ES5 的严格模式只允许在全局作用域或函数作用域声明函数。也就是说，不允许在非函数的代码块内声明函数。
```js
'use strict';
if (true) {
  function f1() { } // 语法错误
}

for (var i = 0; i < 5; i++) {
  function f2() { } // 语法错误
}
```
注意，如果是 ES6 环境，上面的代码不会报错，因为 ES6 允许在代码块之中声明函数。

### 保留字
为了向将来 JavaScript 的新版本过渡，严格模式新增了一些保留字（implements、interface、let、package、private、protected、public、static、yield等）。使用这些词作为变量名将会报错。