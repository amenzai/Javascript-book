# 数值
JavaScript 内部，所有数字都是以64位浮点数形式储存，即使整数也是如此。所以，1与1.0是相同的，是同一个数。

特别注意：
```js
0.1 + 0.2 === 0.3
// false

0.3 / 0.1
// 2.9999999999999996

(0.3 - 0.2) === (0.2 - 0.1)
// false
```

## 数值范围
```js
// 最大值
Number.MAX_VALUE // 1.7976931348623157e+308
// 最小值
Number.MIN_VALUE // 5e-324
```

## 数值的表示法

### 进制

- 十进制：没有前导0的数值。
- 八进制：有前缀0o或0O的数值，或者有前导0、且- 只用到0-7的八个阿拉伯数字的数值。
- 十六进制：有前缀0x或0X的数值。
- 二进制：有前缀0b或0B的数值。

### 科学计数法
```js
123e3 // 123000
123e-3 // 0.123
-3.1E+12
.1e-23
```

## NaN
NaN是 JavaScript 的特殊值，表示“非数字”（Not a Number），主要出现在将字符串解析成数字出错的场合，或者瞎搞的数学计算。

特别注意：
```js
typeof NaN // 'number'
NaN === NaN // false
[NaN].indexOf(NaN) // -1
Boolean(NaN) // false
```

### 判断NaN
```js
isNaN(NaN) // true
isNaN(123) // false
```
isNaN只对数值有效，如果传入其他值，会被先转成数值。
```js
isNaN('Hello') // true
// 相当于
isNaN(Number('Hello')) // true
```

## parseInt()
parseInt方法用于将字符串转为整数。
如果字符串头部有空格，空格会被自动去除。
如果parseInt的参数不是字符串，则会先转为字符串再转换。
字符串转为整数的时候，是一个个字符依次转换，如果遇到不能转为数字的字符，就不再进行下去，返回已经转好的部分。

## parseFloat()
parseFloat方法用于将一个字符串转为浮点数。
注意，parseFloat会将空字符串转为NaN。

多一点，这两个方法与`Number()`不同之处在于，Number()是对字符串整体进行转换，如果有除了数字之外的字符就返回NaN

```JS
parseFloat(true)  // NaN
Number(true) // 1

parseFloat(null) // NaN
Number(null) // 0

parseFloat('') // NaN
Number('') // 0

parseFloat('123.45#') // 123.45
Number('123.45#') // NaN
```
---

还有正无穷`Infinity`，负无穷`-Infinity`

使用isFinite函数检查某个值是不是正常数值，而不是Infinity
