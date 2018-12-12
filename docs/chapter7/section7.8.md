# 排序和搜索算法
常用的排序和搜索算法，冒泡排序、选择排序、插入排序、归并排序、快速排序和堆排序，以及顺序搜索和二分搜索算法。

## 排序算法
对给定信息得先排序再搜索。

JavaScript的Array类定义了一个sort函数（Array.prototype.sort）用以排序JavaScript数组（我们不必自己实现这个算法）。ECMAScript没有定义用哪个排序算法，所以浏览器厂商可以自行去实现算法。例如，Mozilla Firefox使用归并排序作为Array.prototype.sort的实现，而Chrome使用了一个快速排序的变体。

```js
function ArrayList() {
  var array = []; // 创建一个数组（列表）来表示待排序和搜索的数据结构
  var swap = function(index1, index2) {
    var aux = array[index1];
    array[index1] = array[index2];
    array[index2] = aux;
    // ES6 [array[index1], array[index2]] = [array[index2], array[index1]];
  };
  this.insert = function(item) { // 数据结构中插入元素
    array.push(item);
  };
  this.toString = function() { // 输出数据结构中数据
    return array.join();
  };
  // 冒泡排序：冒泡排序比较任何两个相邻的项，如果第一个比第二个大，则交换它们。元素项向上移动至正确的顺序，就好像气泡升至表面一样，冒泡排序因此得名。
  this.bubbleSort = function() {
    var length = array.length;
    for (var i = 0; i < length; i++) { // 每个元素都执行
      for (var j = 0; j < length - 1; j++) {
        if (array[j] > array[j + 1]) {
          swap(j, j + 1);
        }
      }
    }
  };
  // 优化后的冒泡排序
  this.modifiedBubbleSort = function() {
    var length = array.length;
    for (var i = 0; i < length; i++) {
      for (var j = 0; j < length - 1 - i; j++) {
        if (array[j] > array[j + 1]) { // 外循环执行一次后，末尾的值次序已经确定
          swap(j, j + 1);
        }
      }
    }
  };
  // 选择排序：选择排序大致的思路是找到数据结构中的最小值并将其放置在第一位，接着找到第二小的值并将其放在第二位，以此类推。
  this.selectionSort = function() {
    var length = array.length,
      indexMin;
    for (var i = 0; i < length - 1; i++) {
      indexMin = i; // 
      for (var j = i; j < length; j++) {
        if (array[indexMin] > array[j]) {
          indexMin = j;
        }
      }
      if (i !== indexMin) {
        swap(i, indexMin);
      }
    }
  };
  // 插入排序：插入排序每次排一个数组项，以此方式构建最后的排序数组。假定第一项已经排序了，接着，它和第二项进行比较，第二项是应该待在原位还是插到第一项之前呢？这样，头两项就已正确排序，接着和第三项比较（它是该插入到第一、第二还是第三的位置呢？），以此类推。
  this.insertionSort = function() { // 排序小型数组时，此算法比选择排序和冒泡排序性能要好。
    var length = array.length,
      j, temp;
    for (var i = 1; i < length; i++) {
      j = i;
      temp = array[i]; // 便于之后插入到正确位置
      while (j > 0 && array[j - 1] > temp) {
        array[j] = array[j - 1];
        j--;
      }
      array[j] = temp; // 插入
    }
  };
  var merge = function (left, right) {
    var result = [],
      il = 0,
      ir = 0;
    while (il < left.length && ir < right.length) {
      if (left[il] < right[ir]) {
        result.push(left[il++]);
      } else {
        result.push(right[ir++]);
      }
    }
    while (il < left.length) {
      result.push(left[il++]);
    }
    while (ir < right.length) {
      result.push(right[ir++]);
    }
    return result;
  };
  var mergeSortRec = function (array) {
    var length = array.length;
    if (length === 1) {
      return array;
    }
    var mid = Math.floor(length / 2),
      left = array.slice(0, mid),
      right = array.slice(mid, length);
    return merge(mergeSortRec(left), mergeSortRec(right));
  };
  // 归并排序是一种分治算法。其思想是将原始数组切分成较小的数组，直到每个小数组只有一个位置，接着将小数组归并成较大的数组，直到最后只有一个排序完毕的大数组。
  this.mergeSort = function() {
    array = mergeSortRec(array);
  };
  
  var partition = function (array, left, right) {

    var pivot = array[Math.floor((right + left) / 2)],
      i = left,
      j = right;

    while (i <= j) {
      while (array[i] < pivot) {
        i++;
      }
      while (array[j] > pivot) {
        j--;
      }
      if (i <= j) {
        swap(array, i, j);
        i++;
        j--;
      }
    }
    return i;
  };
  var quick = function (array, left, right) {
    var index;
    if (array.length > 1) {
      index = partition(array, left, right);
      if (left < index - 1) {
        quick(array, left, index - 1);
      }
      if (index < right) {
        quick(array, index, right);
      }
    }
  }; 
  // 快速排序也使用分治的方法，将原始数组分为较小的数组（但它没有像归并排序那样将它们分割开）。
  this.quickSort = function () {
    quick(array, 0, array.length - 1);
  };

  var heapify = function(array, heapSize, i){
    var left = i * 2 + 1,
    right = i * 2 + 2,
    largest = i;

    if (left < heapSize && array[left] > array[largest]) {
      largest = left;
    }

    if (right < heapSize && array[right] > array[largest]) {
      largest = right;
    }

    if (largest !== i) {
      swap(array, i, largest);
      heapify(array, heapSize, largest);
    }
  };
  var buildHeap = function(array){
    var heapSize = array.length;
    for (var i = Math.floor(array.length / 2); i >= 0; i--) {
      heapify(array, heapSize, i);
    }
  };
  // 堆排序
  this.heapSort = function() {
    var heapSize = array.length;
    buildHeap(array);

    while (heapSize > 1) {
      heapSize--;
      swap(array, 0, heapSize);
      heapify(array, heapSize, 0);
    }
  };
}
```

## 搜索算法

```js
// 顺序或线性搜索是最基本的搜索算法。它的机制是，将每一个数据结构中的元素和我们要找的元素做比较。顺序搜索是最低效的一种搜索算法。
this.sequentialSearch = function (item) {
  for (var i = 0; i < array.length; i++) {
    if (item === array[i]) {
      return i;
    }
  }
  return -1;
};
// 二分搜索：这个算法要求被搜索的数据结构已排序。
this.binarySearch = function (item) {
  this.quickSort();
  var low = 0,
    high = array.length - 1,
    mid, element;
  while (low <= high) {
    mid = Math.floor((low + high) / 2);
    element = array[mid];
    if (element < item) {
      low = mid + 1;
    } else if (element > item) {
      high = mid - 1;
    } else {
      return mid;
    }
  }
  return -1;
};
```

## 递归
递归是一种解决问题的方法，它解决问题的各个小部分，直到解决最初的大问题。递归通常涉及函数调用自身。

每个递归函数都必须要有边界条件，即一个不再递归调用的条件（停止点），以防止无限递归。

**JavaScript调用栈大小的限制**

如果忘记加上用以停止函数递归调用的边界条件，会发生什么呢？递归并不会无限地执行下去；浏览器会抛出错误，也就是所谓的栈溢出错误（stack overflow error）。

ECMAScript 6有尾调用优化（tail call optimization）。如果函数内最后一个操作是调用函数（就像示例中加粗的那行），会通过“跳转指令”（jump） 而不是“子程序调用”（subroutine call）来控制。也就是说，在ECMAScript 6中，这里的代码可以一直执行下去。所以，具有停止递归的边界条件非常重要。

**斐波那契数列**

```js
// 递归实现
function fibonacci(num){
  if (num === 1 || num === 2){
    return 1;
  }
  return fibonacci(num - 1) + fibonacci(num - 2);
}

// 非递归实现
function fib(num){
  var n1 = 1,
    n2 = 1,
    n = 1;
  for (var i = 3; i<=num; i++){
    n = n1 + n2;
    n1 = n2;
    n2 = n;
  }
  return n;
}
```
为何用递归呢？更快吗？递归并不比普通版本更快，反倒更慢。但要知道，递归更容易理解，并且它所需的代码量更少。

在ECMAScript 6中，因为尾调用优化的缘故，递归并不会更慢。但是在其他语言中，递归通常更慢。

所以，我们用递归，通常是因为它更容易解决问题。

## 动态规划
动态规划（Dynamic Programming，DP）是一种将复杂问题分解成更小的子问题来解决的优化技术。

要注意动态规划和分而治之（归并排序和快速排序算法中用到的那种）是不同的方法。分而治之方法是把问题分解成相互独立的子问题，然后组合它们的答案，而动态规划则是将问题分解成相互依赖的子问题。

用动态规划解决问题时，要遵循三个重要步骤：

(1) 定义子问题；

(2) 实现要反复执行来解决子问题的部分（这一步要参考前一节讨论的递归的步骤）；

(3) 识别并求解出边界条件。




## 在线刷题

这里列出一些有用的网站（有些不支持用JavaScript提交解答，但是我们依然可以将从本书中所学到的逻辑应用到其他语言上）。

- [UVa Online Judge](http://uva.onlinejudge.org)： 这个网站包含了世界各大赛事的题目，包括由IBM赞助的ACM国际大学生程序竞赛（ICPC。若你依然在校，应尽量参与这项赛事，如果团队获胜，则有可能免费享受一次国际旅行）。这个网站包括了成百上千的题目，可以应用本书所学的算法。
- [Sphere Online Judge](http://www.spoj.com)： 这个网站和UVa Online Judge差不多，但支持用更多语言解题（包括JavaScript）。
- [Coder Byte](http://coderbyte.com)：这个网站包含了74个可以用JavaScript解答的题目（简单、中等难度和非常困难）。
- [Project Euler](https://projecteuler.net)：这个网站包含了一系列数学/计算机的编程题目。你所要做的就是输入那些题目的答案，不过我们可以用算法来找到正确的解答。
- [Hacker Rank](https://www.hackerrank.com)：这个网站包含了263个挑战，分为16个类别（可以应用本书中的算法和更多其他算法）。它也支持JavaScript和其他语言。
- [Code Chef](http://www.codechef.com)：这个网站包含一些题目，并会举办在线比赛。
- [Top Coder](http://www.topcoder.com)：此网站会举办算法联赛，这些联赛通常由NASA、Google、Yahoo!、Amazon和Facebook这样的公司赞助。参加其中一些赛事，你可以获得到赞助公司工作的机会，而参与另一些赛事会赢得奖金。这个网站也提供很棒的解题和算法教程。