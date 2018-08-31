# Number对象

## Number()

参照数据类型转换。

## 构造对象属性

- Number.POSITIVE_INFINITY：正的无限，指向Infinity。
- Number.NEGATIVE_INFINITY：负的无限，指向-Infinity。
- Number.NaN：表示非数值，指向NaN。
- Number.MAX_VALUE：表示最大的正数，相应的，最小的负数为-Number.MAX_VALUE。
- Number.MIN_VALUE：表示最小的正数（即最接近0的正数，在64位浮点数体系中为5e-324），相应的，最接近0的负数为-Number.MIN_VALUE。
- Number.MAX_SAFE_INTEGER：表示能够精确表示的最大整数，即9007199254740991。
- Number.MIN_SAFE_INTEGER：表示能够精确表示的最小整数，即-9007199254740991。

```js
Number.POSITIVE_INFINITY // Infinity
Number.NEGATIVE_INFINITY // -Infinity
Number.NaN // NaN

Number.MAX_VALUE
// 1.7976931348623157e+308
Number.MAX_VALUE < Infinity
// true

Number.MIN_VALUE
// 5e-324
Number.MIN_VALUE > 0
// true

Number.MAX_SAFE_INTEGER // 9007199254740991
Number.MIN_SAFE_INTEGER // -9007199254740991
```

## 原型对象方法

### Number.prototype.toString()
将一个数值转为字符串形式。

### Number.prototype.toFixed()
将一个数转为指定位数的小数，返回这个小数对应的字符串。

### Number.prototype.toExponential()
将一个数转为科学计数法形式。

### Number.prototype.toPrecision()
将一个数转为指定位数的有效数字。


