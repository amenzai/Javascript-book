# 链表

数组的大小是固定的，从数组的起点或中间插入或移除项的成本很高，因为需要移动元素（尽管我们已经学过的JavaScript的Array类方法可以帮我们做这些事，但背后的情况同样是这样）。

链表存储有序的元素集合，但不同于数组，链表中的元素在内存中并不是连续放置的。每个元素由一个存储元素本身的节点和一个指向下一个元素的引用（也称指针或链接）组成。

相对于传统的数组，链表的一个好处在于，添加或移除元素的时候不需要移动其他元素。然而，链表需要使用指针，因此实现链表时需要额外注意。数组的另一个细节是可以直接访问任何位置的任何元素，而要想访问链表中间的一个元素，需要从起点（表头）开始迭代列表直到找到所需的元素。

## 代码示例

**单向链表**

```js
function LinkedList() {

  let Node = function (element) {
    this.element = element;
    this.next = null;
  };

  let length = 0;
  let head = null;

  this.append = function (element) {
    let node = new Node(element), // 创建Node项
      current;

    if (head === null) { //列表中第一个节点 //{3}
      head = node;

    } else {
      current = head; //我们只有第一个元素的引用

      //循环列表，直到找到最后一项
      while (current.next) {
        current = current.next;
      }

      //找到最后一项，将其next赋为node，建立链接
      current.next = node; //{5}
    }

    length++; //更新列表的长度 //{6}
  };
  this.insert = function (position, element) {

    //检查越界值
    if (position >= 0 && position <= length) { //{1}

      let node = new Node(element),
        current = head,
        previous,
        index = 0;

      if (position === 0) { //在第一个位置添加

        node.next = current; //{2}
        head = node;

      } else {
        while (index++ < position) { //{3}
          previous = current;
          current = current.next;
        }
        node.next = current; //{4}
        previous.next = node; //{5}
      }

      length++; //更新列表的长度

      return true;

    } else {
      return false; //{6}
    }
  };
  this.removeAt = function (position) {

    //检查越界值
    if (position > -1 && position < length) { // {1}

      let current = head, // {2}
        previous, // {3}
        index = 0; // {4}

      //移除第一项
      if (position === 0) { // {5}
        head = current.next;
      } else {

        while (index++ < position) { // {6}

          previous = current; // {7}
          current = current.next; // {8}
        }

        //将previous与current的下一项链接起来：跳过current，从而移除它
        previous.next = current.next; // {9}
      }

      length--; // {10}

      return current.element;

    } else {
      return null; // {11}
    }
  };
  this.remove = function(element){
    let index = this.indexOf(element);
    return this.removeAt(index);
  };
  this.indexOf = function (element) {

    let current = head, //{1}
      index = -1;

    while (current) { //{2}
      if (element === current.element) {
        return index; //{3}
      }
      index++; //{4}
      current = current.next; //{5}
    }

    return -1;
  };
  this.isEmpty = function() {
    return length === 0;
  };
  this.size = function() {
    return length;
  };
  this.getHead = function(){
    return head;
  };
  this.toString = function () {

    let current = head, //{1}
      string = ''; //{2}

    while (current) { //{3}
      string += current.element + (current.next ? 'n' : ''); //{4}
      current = current.next; //{5}
    }
    return string; //{6}
  };
  this.print = function () {};
}
```

**双向链表**

```js
function DoublyLinkedList() {

  let Node = function (element) {

    this.element = element;
    this.next = null;
    this.prev = null; //新增的
  };

  let length = 0;
  let head = null;
  let tail = null; //新增的

  //这里是方法
  this.insert = function (position, element) {

    //检查越界值
    if (position >= 0 && position <= length) {

      let node = new Node(element),
        current = head,
        previous,
        index = 0;

      if (position === 0) { //在第一个位置添加

        if (!head) { //新增的 {1}
          head = node;
          tail = node;
        } else {
          node.next = current;
          current.prev = node; //新增的 {2}
          head = node;
        }
      } else if (position === length) { //最后一项 //新增的

        current = tail; // {3}
        current.next = node;
        node.prev = current;
        tail = node;

      } else {
        while (index++ < position) { //{4}
          previous = current;
          current = current.next;
        }
        node.next = current; //{5}
        previous.next = node;

        current.prev = node; //新增的
        node.prev = previous; //新增的
      }

      length++; //更新列表的长度

      return true;

    } else {
      return false;
    }
  };
  this.removeAt = function (position) {

    //检查越界值
    if (position > -1 && position < length) {

      let current = head,
        previous,
        index = 0;

      //移除第一项
      if (position === 0) {

        head = current.next; // {1}

        //如果只有一项，更新tail //新增的
        if (length === 1) { // {2}
          tail = null;
        } else {
          head.prev = null; // {3}
        }

      } else if (position === length - 1) { //最后一项 //新增的

        current = tail; // {4}
        tail = current.prev;
        tail.next = null;

      } else {

        while (index++ < position) { // {5}

          previous = current;
          current = current.next;
        }

        //将previous与current的下一项链接起来——跳过current
        previous.next = current.next; // {6}
        current.next.prev = previous; //新增的
      }

      length--;

      return current.element;

    } else {
      return null;
    }
  };
}
```

**双向循环链**表有指向head元素的tail.next，和指向tail元素的head.prev。