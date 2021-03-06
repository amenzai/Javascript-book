# Array 对象

## 构造对象方法

### Array.isArray()

用来判断一个值是否为数组
```js
var a = [1, 2, 3];

typeof a // "object"
Array.isArray(a) // true
```

## 原型对象方法
### valueOf()，toString()

valueOf方法返回数组本身。
```js
var a = [1, 2, 3];
a.valueOf() // [1, 2, 3]
```

toString方法返回数组的字符串形式。
```js
var a = [1, 2, 3];
a.toString() // "1,2,3"

var a = [1, 2, 3, [4, 5, 6]];
a.toString() // "1,2,3,4,5,6"
```

### push()
push方法用于在数组的末端添加一个或多个元素，并返回添加新元素后的数组长度。

注意：该方法会改变原数组。

合并两个数组，可以这样写。
```js
var a = [1, 2, 3];
var b = [4, 5, 6];

Array.prototype.push.apply(a, b)
// 或者
a.push.apply(a, b)

// 上面两种写法等同于
a.push(4, 5, 6)

a // [1, 2, 3, 4, 5, 6]
```

### pop()
用于删除数组的最后一个元素，并返回该元素。

注意：该方法会改变原数组。

### join()
以参数作为分隔符，将所有数组成员组成一个字符串返回。如果不提供参数，默认用逗号分隔。

### concat()
用于多个数组的合并。它将新数组的成员，添加到原数组成员的后部，然后返回一个新数组，原数组不变。

### shift()
用于删除数组的第一个元素，并返回该元素。

注意：该方法会改变原数组。

### unshift()
用于在数组的第一个位置添加元素，并返回添加新元素后的数组长度。

注意：该方法会改变原数组。

### reverse()
用于颠倒数组中元素的顺序，返回改变后的数组。

注意：该方法将改变原数组。

### slice()
用于提取原数组的一部分，返回一个新数组，原数组不变。

它的第一个参数为起始位置（从0开始），第二个参数为终止位置（但该位置的元素本身不包括在内）。如果省略第二个参数，则一直返回到原数组的最后一个成员。

### splice()
用于删除原数组的一部分成员，并可以在被删除的位置添加入新的数组成员，返回值是被删除的元素。

注意：该方法会改变原数组。

splice的第一个参数是删除的起始位置，第二个参数是被删除的元素个数。如果后面还有更多的参数，则表示这些就是要被插入数组的新元素。

### sort()
对数组成员进行排序，默认是按照字典顺序排序。排序后，原数组将被改变。

特别注意：

sort方法不是按照大小排序，而是按照对应字符串的字典顺序排序。也就是说，数值会被先转成字符串，再按照字典顺序（ASCII值）进行比较，所以101排在11的前面。

自定义方式排序：
```js
// 数值排序
[10111, 1101, 111].sort(function (a, b) {
  return a - b;
})
// [111, 1101, 10111]

[
  { name: "张三", age: 30 },
  { name: "李四", age: 24 },
  { name: "王五", age: 28  }
].sort(function (o1, o2) {
  return o1.age - o2.age;
})
// [
//   { name: "李四", age: 24 },
//   { name: "王五", age: 28  },
//   { name: "张三", age: 30 }
// ]

// 比较函数
function compare(a, b) {
  if (a < b) {
    return -1;
  }
  if (a > b) {
    return 1;
  }
  // a必须等于
  return 0;
}
arr.sort(compare);

// 字符串排序
var names = ['Ana', 'ana', 'john', 'John'];
names.sort(function (a, b) {
  if (a.toLowerCase() < b.toLowerCase()) {
    return -1
  }
  if (a.toLowerCase() > b.toLowerCase()) {
    return 1
  }
  return 0;
});
```

### map()
对数组的所有成员依次调用一个函数，根据函数结果返回一个新数组。

### forEach()
forEach方法与map方法很相似，也是遍历数组的所有成员，执行某种操作，但是forEach方法一般不返回值，只用来操作数据。如果需要有返回值，一般使用map方法。

### filter()
filter方法的参数是一个函数，所有数组成员依次执行该函数，返回结果为true的成员组成一个新数组返回。

该方法不会改变原数组。

### some()，every()
这两个方法类似“断言”（assert），用来判断数组成员是否符合某种条件。

它们接受一个函数作为参数，所有数组成员依次执行该函数，返回一个布尔值。该函数接受三个参数，依次是当前位置的成员、当前位置的序号和整个数组。

some方法是只要有一个数组成员的返回值是true，则整个some方法的返回值就是true，否则false。

every方法则是所有数组成员的返回值都是true，才返回true，否则false。

### reduce()，reduceRight()
reduce方法和reduceRight方法依次处理数组的每个成员，最终累计为一个值。

它们的差别是，reduce是从左到右处理（从第一个成员到最后一个成员），reduceRight则是从右到左（从最后一个成员到第一个成员），其他完全一样。
```js
[1, 2, 3, 4, 5].reduce(function(x, y){
  console.log(x, y)
  return x + y;
});
// 1 2
// 3 3
// 6 4
// 10 5
//最后结果：15
```
如果要对累积变量指定初值，可以把它放在reduce方法和reduceRight方法的第二个参数。
```js
[1, 2, 3, 4, 5].reduce(function(x, y){
  return x + y;
}, 10);
// 25
```

### indexOf()，lastIndexOf()
indexOf方法返回给定元素在数组中第一次出现的位置，如果没有出现则返回-1。

lastIndexOf方法返回给定元素在数组中最后一次出现的位置，如果没有出现则返回-1。

### 遍历
```js
// 多维数组创建
var matrix3x3x3 = [];
for (var i = 0; i < 3; i++) {
  matrix3x3x3[i] = [];
  for (var j = 0; j < 3; j++) {
    matrix3x3x3[i][j] = [];
    for (var z = 0; z < 3; z++) {
      matrix3x3x3[i][j][z] = i + j + z;
    }
  }
}
// 多维数组遍历
for (var i = 0; i < matrix3x3x3.length; i++) {
  for (var j = 0; j < matrix3x3x3[i].length; j++) {
    for (var z = 0; z < matrix3x3x3[i][j].length; z++) {
      console.log(matrix3x3x3[i][j][z]);
    }
  }
}
```