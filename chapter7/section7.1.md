# 栈

栈是一种遵从后进先出（LIFO）原则的有序集合。新添加的或待删除的元素都保存在栈的末尾，称作栈顶，另一端就叫栈底。在栈里，新元素都靠近栈顶，旧元素都接近栈底。

## 代码示例：

```js
// 书，盘子
function Stack() {
  var items = []; // 需要一种数据结构来保存栈里的元素
  this.push = function(element) { // 添加一个（或几个）新元素到栈顶。
    items.push(element);
  };
  this.pop = function() { // 移除栈顶的元素，同时返回被移除的元素。
    return items.pop();
  };
  this.peek = function() { // 返回栈顶的元素，不对栈做任何修改（这个方法不会移除栈顶的元素，仅仅返回它）。
    return items[items.length - 1];
  };
  this.isEmpty = function() { // 如果栈里没有任何元素就返回true，否则返回false。
    return items.length == 0;
  };
  this.size = function() { // ：返回栈里的元素个数
    return items.length;
  };
  this.clear = function() { // 移除栈里的所有元素。
    items = [];
  };
  this.print = function() {
    console.log(items.toString());
  };
}
var stack = new Stack(); // 初始化Stack类


/**
 * 数值进制转换    // 用它解决一些计算机科学中的问题。
 * @param {*Number} decNumber 数值
 * @param {*Number} base 进制数
 */
function baseConverter(decNumber, base) {
  var remStack = new Stack(),
    rem,
    baseString = '',
    digits = '0123456789ABCDEF'; //{6}
  while (decNumber > 0) {
    rem = Math.floor(decNumber % base);
    remStack.push(rem);
    decNumber = Math.floor(decNumber / base);
  }
  while (!remStack.isEmpty()) {
    baseString += digits[remStack.pop()]; //{7}
  }
  return baseString;
}
```