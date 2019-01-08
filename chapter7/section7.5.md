# 字典和散列表

集合、字典和散列表可以存储不重复的值。在集合中，我们感兴趣的是每个值本身，并把它当作主要元素。在字典中，我们用[键，值]的形式来存储数据。在散列表中也是一样（也是以[键，值]对的形式来存储数据）。

## 字典

**代码示例**

```js
function Dictionary() {
  var items = {};
  this.has = function (key) {
    // return key in items;
    return items.hasOwnProperty(key);
  };
  this.set = function (key, value) {
    items[key] = value;
  };
  this.delete = function (key) {
    if (this.has(key)) {
      delete items[key];
      return true;
    }
    return false;
  };
  this.get = function (key) {
    return this.has(key) ? items[key] : undefined;
  };
  this.values = function () {
    var values = [];
    for (var k in items) { //{1}
      if (this.has(k)) {
        values.push(items[k]); //{2}
      }
    }
    return values;
  };
  this.keys = function () {
    return Object.keys(items);
  };
  this.getItems = function () {
    return items;
  }
  this.clear = function () {
    items = {}; // {3}
  };
  this.size = function () {
    return Object.keys(items).length; //{4}
  };
}
```

## 散列表

散列算法的作用是尽可能快地在数据结构中找到一个值。在之前的章节中，你已经知道如果要在数据结构中获得一个值（使用get方法），需要遍历整个数据结构来找到它。如果使用散列函数，就知道值的具体位置，因此能够快速检索到该值。散列函数的作用是给定一个键值，然后返回值在表中的地址。

**代码示例**

```js
function HashTable() {
  var table = [];
  var loseloseHashCode = function (key) {
    var hash = 0; //{1}
    for (var i = 0; i < key.length; i++) { //{2}
      hash += key.charCodeAt(i); //{3}
    }
    return hash % 37; //{4}为了得到比较小的数值，我们会使用hash值和一个任意数做除法的余数
  };

  this.put = function (key, value) {
    var position = loseloseHashCode(key); //{5}
    console.log(position + ' - ' + key); //{6}
    table[position] = value; //{7}
  };

  this.get = function (key) {
    // 由于元素分布于整个数组范围内，一些位置会没有任何元素占据，并默认为undefined值。
    // 我们也不能将位置本身从数组中移除（这会改变其他元素的位置），否则，当下次需要获得或移除一个元素的时候，这个元素会不在我们用散列函数求出的位置上。
    return table[loseloseHashCode(key)];
  };

  this.remove = function (key) {
    table[loseloseHashCode(key)] = undefined;
  };

}

```

### 散列表和散列集合

在一些编程语言中，还有一种叫作散列集合的实现。散列集合由一个集合构成，但是插入、移除或获取元素时，使用的是散列函数。我们可以重用本章中实现的所有代码来实现散列集合，不同之处在于，不再添加键值对，而是只插入值而没有键。例如，可以使用散列集合来存储所有的英语单词（不包括它们的定义）。和集合相似，散列集合只存储唯一的不重复的值。

### 处理散列表中的冲突

有时候，一些键会有相同的散列值。不同的值在散列表中对应相同位置的时候，我们称其为冲突。

处理冲突有几种方法：分离链接、线性探查和双散列法。在本书中，我们会介绍前两种方法。

**分离链接**

分离链接法包括为散列表的每一个位置创建一个链表并将元素存储在里面。它是解决冲突的最简单的方法，但是它在HashTable实例之外还需要额外的存储空间。

```js
  var ValuePair = function (key, value) {
    this.key = key;
    this.value = value;

    this.toString = function () {
      return '[' + this.key + ' - ' + this.value + ']';
    }
  };

  this.put = function (key, value) {
    var position = loseloseHashCode(key);

    if (table[position] == undefined) { //{1}
      table[position] = new LinkedList();
    }
    table[position].append(new ValuePair(key, value)); //{2}
  };

  this.get = function (key) {
    var position = loseloseHashCode(key);

    if (table[position] !== undefined) { //{3}

      //遍历链表来寻找键/值
      var current = table[position].getHead(); //{4}

      while (current.next) { //{5}
        if (current.element.key === key) { //{6}
          return current.element.value; //{7}
        }
        current = current.next; //{8}
      }

      //检查元素在链表第一个或最后一个节点的情况
      if (current.element.key === key) { //{9}
        return current.element.value;
      }
    }
    return undefined; //{10}
  };

  this.remove = function (key) {
    var position = loseloseHashCode(key);

    if (table[position] !== undefined) {

      var current = table[position].getHead();
      while (current.next) {
        if (current.element.key === key) { //{11}
          table[position].remove(current.element); //{12}
          if (table[position].isEmpty()) { //{13}
            table[position] = undefined; //{14}
          }
          return true; //{15}
        }
        current = current.next;
      }

      // 检查是否为第一个或最后一个元素
      if (current.element.key === key) { //{16}
        table[position].remove(current.element);
        if (table[position].isEmpty()) {
          table[position] = undefined;
        }
        return true;
      }
    }

    return false; //{17}
  };
```

**线性探查**

另一种解决冲突的方法是线性探查。当想向表中某个位置加入一个新元素的时候，如果索引为index的位置已经被占据了，就尝试index+1的位置。如果index+1的位置也被占据了，就尝试index+2的位置，以此类推。

```js
this.put = function (key, value) {
  var position = loseloseHashCode(key); // {1}

  if (table[position] == undefined) { // {2}
    table[position] = new ValuePair(key, value); // {3}
  } else {
    var index = ++position; // {4}
    while (table[index] != undefined) { // {5}
      index++; // {6}
    }
    table[index] = new ValuePair(key, value); // {7}
  }
};
this.get = function (key) {
  var position = loseloseHashCode(key);

  if (table[position] !== undefined) { //{8}
    if (table[position].key === key) { //{9}
      return table[position].value; //{10}
    } else {
      var index = ++position;
      while (table[index] === undefined ||
        table[index].key !== key) { //{11}
        index++;
      }
      if (table[index].key === key) { //{12}
        return table[index].value; //{13}
      }
    }
  }
  return undefined; //{14}
};
this.remove = function (key) {
  var position = loseloseHashCode(key);

  if (table[position] !== undefined) { //{8}
    if (table[position].key === key) { //{9}
      table[position] = undefined;
      return true;
    } else {
      var index = ++position;
      while (table[index] === undefined ||
        table[index].key !== key) { //{11}
        index++;
      }
      if (table[index].key === key) { //{12}
        table[index] = undefined;
        return true;
      }
    }
  }
  return false; //{14}
};
```

**创建更好的散列函数**

我们实现的“lose lose”散列函数并不是一个表现良好的散列函数，因为它会产生太多的冲突。如果我们使用这个函数的话，会产生各种各样的冲突。一个表现良好的散列函数是由几个方面构成的：插入和检索元素的时间（即性能），当然也包括较低的冲突可能性。我们可以在网上找到一些不同的实现方法，或者也可以实现自己的散列函数。

另一个可以实现的比“lose lose”更好的散列函数是djb2：

```js
var djb2HashCode = function (key) {
  var hash = 5381; //质数
  for (var i = 0; i < key.length; i++) { //{2}
    hash = hash * 33 + key.charCodeAt(i); //33：魔力数
  }
  return hash % 1013; //随机质数：我们认为的散列表的大小要大
};
```