# 数据类型
JavaScript 语言的每一个值，都属于某一种数据类型。JavaScript 的数据类型，共有六种。

- 数值（number）：整数和小数（比如1和3.14）
- 字符串（string）：字符组成的文本（比如”Hello World”）
- 布尔值（boolean）：true（真）和false（假）两个特定值
- undefined：表示“未定义”或不存在，即由于目前没有定义，所以此处暂时没有任何值
- null：表示无值，即此处的值就是“无”的状态。
- 对象（object）：各种值组成的集合

## 判断数据类型

### typeof运算符
```js
typeof 123 // "number"
typeof '123' // "string"
typeof false // "boolean"

function f() {}
typeof f // "function"

typeof undefined // "undefined"

typeof window // "object"
typeof {} // "object"
typeof [] // "object"
typeof null // "object"
```
上面需要注意的是，一个变量声明了没初始化，或者未声明`typeof`后都是`undefined`

关于unfefined与null需知：
```js
undefined == null
// true
```

### instanceof运算符


### Object.prototype.toString方法

## 关于布尔值
进行布尔转换时，除了下面六个值被转为false，其他值都视为true。

- undefined
- null
- false
- 0
- NaN
- ""或''（空字符串）

> 一般常在if判断中自动转换