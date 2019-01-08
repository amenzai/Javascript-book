# 集合

迄今为止，我们已经学习了数组（列表）、栈、队列和链表（及其变种）等顺序数据结构。在这一章中，我们要学习集合，这是一种不允许值重复的顺序数据结构。

本章，你会学到如何创建集合这种数据结构，如何添加和移除值，如何搜索值是否存在。你也会学到如何进行并集、交集、差集等数学操作，还会学到如何使用ES6（ECMAScript 6）原生的Set类。

## 代码示例

```js
function Set() {
  let items = {};
  this.has = function (value) {
    // return value in items;
    return items.hasOwnProperty(value);
  };
  this.add = function (value) {
    if (!this.has(value)) {
      items[value] = value; //{1}
      return true;
    }
    return false;
  };
  this.remove = function (value) {
    if (this.has(value)) {
      delete items[value]; //{2}
      return true;
    }
    return false;
  };
  this.clear = function () {
    items = {}; // {3}
  };
  this.size = function () {
    return Object.keys(items).length; //{4}
  };
  this.values = function () {
    // let values = [];
    // for (let i = 0, valuesArr = Object.values(items); i < valuesArr.length; i++) {
    //   values.push(valuesArr[i]);
    // }
    // return values;
    return Object.values(items)
  };
  // 并集
  this.union = function (otherSet) {
    let unionSet = new Set(); //{1}

    let values = this.values(); //{2}
    for (let i = 0; i < values.length; i++) {
      unionSet.add(values[i]);
    }

    values = otherSet.values(); //{3}
    for (let i = 0; i < values.length; i++) {
      unionSet.add(values[i]);
    }

    return unionSet;
  };
  // 交集
  this.intersection = function (otherSet) {
    let intersectionSet = new Set(); //{1}

    let values = this.values();
    for (let i = 0; i < values.length; i++) { //{2}
      if (otherSet.has(values[i])) { //{3}
        intersectionSet.add(values[i]); //{4}
      }
    }

    return intersectionSet;
  }
  //  差集
  this.difference = function (otherSet) {
    let differenceSet = new Set(); //{1}

    let values = this.values();
    for (let i = 0; i < values.length; i++) { //{2}
      if (!otherSet.has(values[i])) { //{3}
        differenceSet.add(values[i]); //{4}
      }
    }

    return differenceSet;
  };
  // 子集
  this.subset = function (otherSet) {

    if (this.size() > otherSet.size()) { //{1}
      return false;
    } else {
      let values = this.values();
      for (let i = 0; i < values.length; i++) { //{2}
        if (!otherSet.has(values[i])) { //{3}
          return false; //{4}
        }
      }
      return true; //{5}
    }
  };
}
```