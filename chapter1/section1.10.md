# 错误处理机制
## Error对象
JavaScript解析或执行时，一旦发生错误，引擎就会抛出一个错误对象。JavaScript原生提供一个Error构造函数，所有抛出的错误都是这个构造函数的实例。
```js
var err = new Error('出错了');
err.message // "出错了"
```

## JavaScript的原生错误类型
- SyntaxError：语法错误
- ReferenceError：引用一个不存在的变量时发生的错误。
- TypeError：变量或参数不是预期类型时发生的错误
- URIError：URI相关函数的参数不正确时抛出的错误

```js
new Error('出错了！');
new RangeError('出错了，变量超出有效范围！');
new TypeError('出错了，变量类型无效！');
```
实例的message属性可以获取抛出的错误信息。

## 自定义错误
```js
function UserError(message) {
   this.message = message || "默认信息";
   this.name = "UserError";
}

UserError.prototype = new Error();
UserError.prototype.constructor = UserError;

new UserError('这是自定义的错误！');
```
## throw语句
```js
if (x < 0) {
  throw new Error('x 必须为正数');
}

// 抛出一个字符串
throw "Error！";

// 抛出一个数值
throw 42;

// 抛出一个布尔值
throw true;

// 抛出一个对象
throw {toString: function() { return "Error!"; } };
```
JavaScript引擎一旦遇到throw语句，就会停止执行后面的语句，引擎会接收到throw抛出的信息，可能是一个错误实例，也可能是其他类型的值。

## try catch 结构
为了对错误进行处理，需要使用`try...catch`结构。
```js
var n = 100;

try {
  throw n;
} catch (e) {
  if (e <= 50) {
    // ...
  } else {
    throw e;
  }
}
```

为了捕捉不同类型的错误，catch代码块之中可以加入判断语句。

```js
try {
  foo.bar();
} catch (e) {
  if (e instanceof EvalError) {
    console.log(e.name + ": " + e.message);
  } else if (e instanceof RangeError) {
    console.log(e.name + ": " + e.message);
  }
  // ...
}
```

## finally代码块
`try...catch`结构允许在最后添加一个`finally`代码块，表示不管是否出现错误，都必需在最后运行的语句。
```js
openFile();

try {
  writeFile(Data);
} catch(e) {
  handleError(e);
} finally {
  closeFile();
}
```