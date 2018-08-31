# 排序和搜索算法

## 排序算法

```js
function ArrayList() {
  var array = [];
  var swap = function(index1, index2) {
    var aux = array[index1];
    array[index1] = array[index2];
    array[index2] = aux;
  };
  this.insert = function(item) { //{2}
    array.push(item);
  };
  this.toString = function() { //{3}
    return array.join();
  };
  this.bubbleSort = function() {
    var length = array.length; //{1}
    for (var i = 0; i < length; i++) { //{2}
      for (var j = 0; j < length - 1; j++) { //{3}
        if (array[j] > array[j + 1]) { //{4}
          swap(j, j + 1); //{5}
        }
      }
    }
  };
  this.modifiedBubbleSort = function() {
    var length = array.length;
    for (var i = 0; i < length; i++) {
      for (var j = 0; j < length - 1 - i; j++) { //{1}
        if (array[j] > array[j + 1]) {
          swap(j, j + 1);
        }
      }
    }
  };
  this.selectionSort = function() {
    var length = array.length, //{1}
      indexMin;
    for (var i = 0; i < length - 1; i++) { //{2}
      indexMin = i; //{3}
      for (var j = i; j < length; j++) { //{4}
        if (array[indexMin] > array[j]) { //{5}
          indexMin = j; //{6}
        }
      }
      if (i !== indexMin) { //{7}
        swap(i, indexMin);
      }
    }
  };
  this.insertionSort = function() { // 排序小型数组时，此算法比选择排序和冒泡排序性能要好。
    var length = array.length, //{1}
      j, temp;
    for (var i = 1; i < length; i++) { //{2}
      j = i; //{3}
      temp = array[i]; //{4}
      while (j > 0 && array[j - 1] > temp) { //{5}
        array[j] = array[j - 1]; //{6}
        j--;
      }
      array[j] = temp; //{7}
    }
  };
  this.mergeSort = function() {
    array = mergeSortRec(array);
  };
  this.quickSort = function () {
    quick(array, 0, array.length - 1);
  };
  this.sequentialSearch = function (item) {
    for (var i = 0; i < array.length; i++) { //{1}
      if (item === array[i]) { //{2}
        return i; //{3}
      }
    }
    return -1; //{4}
  };
  this.binarySearch = function (item) {
    this.quickSort(); //{1}
    var low = 0, //{2}
      high = array.length - 1, //{3}
      mid, element;
    while (low <= high) { //{4}
      mid = Math.floor((low + high) / 2); //{5}
      element = array[mid]; //{6}
      if (element < item) { //{7}
        low = mid + 1; //{8}
      } else if (element > item) { //{9}
        high = mid - 1; //{10}
      } else {
        return mid; //{11}
      }
    }
    return -1; //{12}
  };
}

var mergeSortRec = function (array) {
  var length = array.length;
  if (length === 1) { //{1}
    return array; //{2}
  }
  var mid = Math.floor(length / 2), //{3}
    left = array.slice(0, mid), //{4}
    right = array.slice(mid, length); //{5}
  return merge(mergeSortRec(left), mergeSortRec(right)); //{6}
};

var merge = function (left, right) {
  var result = [], // {7}
    il = 0,
    ir = 0;
  while (il < left.length && ir < right.length) { // {8}
    if (left[il] < right[ir]) {
      result.push(left[il++]); // {9}
    } else {
      result.push(right[ir++]); // {10}
    }
  }
  while (il < left.length) { // {11}
    result.push(left[il++]);
  }
  while (ir < right.length) { // {12}
    result.push(right[ir++]);
  }
  return result; // {13}
};

var quick = function (array, left, right) {
  var index; //{1}
  if (array.length > 1) { //{2}
    index = partition(array, left, right); //{3}
    if (left < index - 1) { //{4}
      quick(array, left, index - 1); //{5}
    }
    if (index < right) { //{6}
      quick(array, index, right); //{7}
    }
  }
};

```

### 冒泡排序

### 选择排序

### 插入排序

### 归并排序

### 快速排序

## 搜索算法

```js


### 顺序搜索

### 二分搜索