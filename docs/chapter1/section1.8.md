# 运算符
只说一下void。

void(0)返回undefined

主要用于这里
```js
<a href="javascript:void window.open('http://example.com/')">
  点击打开新窗口
</a>
<a href="javascript:void(0);"></a>
```
目的是返回undefined可以防止网页跳转。

对于运算符的优先级问题，记不住的话，直接加括号-。-

逗号运算符：总是返回最后一个表达式的值。

赋值运算符（=）和三元条件运算符（?:）是从右边开始计算的。

二进制位运算符：
[参考文章](https://wangdoc.com/javascript/operators/bit.html)
