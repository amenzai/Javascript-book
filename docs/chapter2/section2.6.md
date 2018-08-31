# Math对象

## 属性

- Math.E：常数e。
- Math.LN2：2的自然对数。
- Math.LN10：10的自然对数。
- Math.LOG2E：以2为底的e的对数。
- Math.LOG10E：以10为底的e的对数。
- Math.PI：常数Pi。
- Math.SQRT1_2：0.5的平方根。
- Math.SQRT2：2的平方根。

## 方静态法

- Math.abs()：绝对值
- Math.ceil()：向上取整
- Math.floor()：向下取整
- Math.max()：最大值
- Math.min()：最小值
- Math.pow()：指数运算
- Math.sqrt()：平方根
- Math.log()：自然对数
- Math.exp()：e的指数
- Math.round()：四舍五入
- Math.random()：随机数

## 三角函数方法

- Math.sin()：返回参数的正弦（参数为弧度值）
- Math.cos()：返回参数的余弦（参数为弧度值）
- Math.tan()：返回参数的正切（参数为弧度值）
- Math.asin()：返回参数的反正弦（返回值为弧度值）
- Math.acos()：返回参数的反余弦（返回值为弧度值）
- Math.atan()：返回参数的反正切（返回值为弧度值）

任意范围的随机数生成函数如下。

```js
function getRandomArbitrary(min, max) {
  return Math.random() * (max - min) + min;
}

getRandomArbitrary(1.5, 6.5)
// 2.4942810038223864
```

任意范围的随机整数生成函数如下。

```js
function getRandomInt(min, max) {
  return Math.floor(Math.random() * (max - min + 1)) + min;
}

getRandomInt(1, 6) // 5
```