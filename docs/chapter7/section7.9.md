# 算法面试总结

数据存储和运算是计算机工作的主要内容，`程序=数据结构+算法`。

## 知识点梳理

- 常见数据结构
  - 栈、队列、链表
  - 集合、字典、散列表
- 常见算法
  - 递归
  - 排序
  - 枚举
- 算法复杂度分析
- 算法思维
  - 分治
  - 贪心
  - 动态规划
- 高级数据结构
  - 树、图
  - 深度优先和广度优先搜索

## 数据结构

有序数组的二分查找，要比普通的顺序查找快很多，尤其是在处理大量数据的时候。

有序数据结构节省空间，无序数据结构省时间。

## 算法复杂度

- 常数阶：O(1)
- 对数阶：O(logN)
- 线性阶：O(n)
- 线性对数阶：O(nlogN)
- 平方阶：O(n^2)
- 立方阶：O(n^3)
- !k次方阶：O(n^k)
- 指数阶：O(z^n)

## 题目

1、使用 JS 实现一个事件类 Event，包含下面功能：绑定事件、解绑事件和派发事件。

```js
Class Event {
  constructor() {
    // 存储事件的数据结构
    this._cache = {};
  }
  // 绑定
  on(type, callback) {
    // 同一类型事件放到一个数组
    let fns = (this._cache[type] = this._cache[type] || []);
    if (fns.indexOf(callback) === -1) {
      fns.push(callback)；
    }
    return this;
  }
  // 触发
  trigger(type, data) {
    let fns = this._cache[type];
    if (Array.isArray(fns)) {
      fns.forEach((fns) => {
        fn(data)
      });
    }
    return this
  }
  // 解绑
  off(type, callback) {
    let fns = this._cache[type];
    if (Array.isArray(fns)) {
      if (callback) {
        let index = fns.indexOf(callback);
        if (index !== -1) {
          fns.splice(index ,1);
        }
      } else {
        // 全部清空
        fns.length = 0;
      }
    }
    return this
  }
}
// test
const event = new Event();
event.on('test', (a) => {
  console.log(a);
})
event.trigger('test', 'hello world');
event.off('test');
event.trigger('test', 'hello world');
```
2、复杂度分析

```js
let number = 1; // 一次
while (number < n) {
  number *= 2; // logN 次
}
// o(logN)
```
3、对象深拷贝
```js
function deepClone(o1, o2) {
  for (let k in o2) {
    if (typeof o2[k] === 'object') {
      o1[k] = {}
      deepClone(o1[k], o2[k])
    } else {
      o1[k] = o2[k];
    }
  }
}
// test
let obj = {
  a: 1,
  b: [1, 2, 3],
  c: {}
}
let emptyObj = Object.create(null);
deepClone(emptyObj, obj);
console.log(emptyObj.a === obj.a);
console.log(emptyObj.b === obj.b);

```
4、求斐波那契数列
```js
let count = 0;
function fn(n) {
  let cache = {};
  function _fn(n) {
    if (cache[n]) {
      return cache[n]
    }
    count++
    if (n == 1 || n == 2) {
      return 1;
    }
    let prev = _fn(n - 1);
    cache[n - 1] = prev;
    let next = _fn(n - 2);
    cache[n - 2] = next;
    return prev + next
  }
  return _fn(n)
}

let count2 = 0;
function fn2(n) {
  count2++
  if (n === 1 || n === 2) {
    return 1
  }
  return fn2(n - 1) + fn2(n - 2)
}

// test
console.log(fn(20), count); // 6765 20
console.log(fn2(20), count2); / 6765 13529
```
## 其他

### 面试遇见不会的算法问题怎么办

揣摩面试官意图，听好关键词。比如：有序的数列做查找、要求算法复杂度是`O(logN)`，这类一般就是用二分的思想。

一般来说算法题目的解题思路分以下四步：

1. 先降低数量级，拿可以计算出来的情况（数据）来构思解题步骤。
2. 根据解题步骤编写程序，优先将特殊情况做好判断处理，比如一个大数组的问题，如果数组为两个数的长度的情况。
3. 检验程序正确性。
4. 是否可以优化（由浅入深），有能力的话可以故意预留优化点，这样可以体现个人技术能力。

### 正则匹配解题

很多算法题目利用 ES 语法特性来回答更加简单。

1、字符串中第一个出现一次的字符

```js
function find(str) {
  for(var i = 0; i < str.length; i++) {
    let char = str[i]
    let reg = new RegExp(char, 'g)
    let l = str.match(reg).length
    if (l === 1) {
      return char
    }
  }
}

```
2、将 123456 变成 1,234,567，即千分位标注

*零宽断言*

```js
function exchange(num) {
  num += '';
  if (num.length <= 3) {
    return num
  }

  num = num.replace(/\d{1,3}(?=(\d{3})+$)/g, (v) => {
    console.log(v)
    return v + ','
  })
  return num
}
console.log(exchange(1234567))
```
3、考察正则

```js
var str = 'google'
var reg = /o/g
console.log(reg.test(str), reg.lastIndex) // true 2
console.log(reg.test(str), reg.lastIndex) // true 3
console.log(reg.test(str), reg.lastIndex) // false 0

// good
(function(){
  const reg = /o/g
  function isHasO(str) {
    reg.lastIndex = 0
    return reg.test(str)
  }
  var str = 'google'
  console.log(isHasO(str))
  console.log(isHasO(str))
  console.log(isHasO(str))
})()

```