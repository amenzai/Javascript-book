# 链表

数组的大小是固定的，从数组的起点或中间插入或移除项的成本很高，因为需要移动元素（尽管我们已经学过的JavaScript的Array类方法可以帮我们做这些事，但背后的情况同样是这样）。

链表存储有序的元素集合，但不同于数组，链表中的元素在内存中并不是连续放置的。每个元素由一个存储元素本身的节点和一个指向下一个元素的引用（也称指针或链接）组成。下图展示了一个链表的结构

## 代码示例

**单向链表**

```js
function Node(element) {
   this.element = element;
   this.next = null;
}

function LList() {
   this.head = new Node("head");
   this.find = find;
   this.insert = insert;
   this.display = display;
   this.findPrevious = findPrevious;
   this.remove = remove;
}

function remove(item) {
   var prevNode = this.findPrevious(item);
   if (!(prevNode.next == null)) {
       prevNode.next = prevNode.next.next;
   }
}

function findPrevious(item) {
   var currNode = this.head;
   while (!(currNode.next == null) && 
           (currNode.next.element != item)) {
      currNode = currNode.next;
   }
   return currNode;
}

function display() {
   var currNode = this.head;
   while (!(currNode.next == null)) {
      console.log(currNode.next.element);
      currNode = currNode.next;
   }
}

function find(item) {
   var currNode = this.head;
   while (currNode.element != item) {
      currNode = currNode.next;
   }
   return currNode;
}

function insert(newElement, item) {
   var newNode = new Node(newElement);
   var current = this.find(item);
   newNode.next = current.next;
   current.next = newNode;
}
   

var cities = new LList();
cities.insert("Conway", "head");
cities.insert("Russellville", "Conway");
cities.insert("Carlisle", "Russellville");
cities.insert("Alma", "Carlisle");
cities.display();
console.log();
cities.remove("Carlisle");
cities.display();
```

**双向链表**

```js
function Node(element) {
   this.element = element;
   this.next = null;
   this.previous = null;
}

function LList() {
   this.head = new Node("head");
   this.find = find;
   this.insert = insert;
   this.display = display;
   this.remove = remove;
   this.findLast = findLast;
   this.dispReverse = dispReverse;
}

function dispReverse() {
   var currNode = this.head;
   currNode = this.findLast();
   while (!(currNode.previous == null)) {
      console.log(currNode.element);
      currNode = currNode.previous;
   }
}

function findLast() {
   var currNode = this.head;
   while (!(currNode.next == null)) {
      currNode = currNode.next;
   }
   return currNode;
}

function remove(item) {
   var currNode = this.find(item);
   if (!(currNode.next == null)) {
       currNode.previous.next = currNode.next;
       currNode.next.previous = currNode.previous;
       currNode.next = null;
       currNode.previous = null;
   }
}

// findPrevious is no longer needed
/*function findPrevious(item) {
   var currNode = this.head;
   while (!(currNode.next == null) && 
           (currNode.next.element != item)) {
      currNode = currNode.next;
   }
   return currNode;
}*/

function display() {
   var currNode = this.head;
   while (!(currNode.next == null)) {
      console.log(currNode.next.element);
      currNode = currNode.next;
   }
}

function find(item) {
   var currNode = this.head;
   while (currNode.element != item) {
      currNode = currNode.next;
   }
   return currNode;
}

function insert(newElement, item) {
   var newNode = new Node(newElement);
   var current = this.find(item);
   newNode.next = current.next;
   newNode.previous = current;
   current.next = newNode;
}
   

var cities = new LList();
cities.insert("Conway", "head");
cities.insert("Russellville", "Conway");
cities.insert("Carlisle", "Russellville");
cities.insert("Alma", "Carlisle");
cities.display();
console.log();
cities.remove("Carlisle");
cities.display();
console.log();
cities.dispReverse();
```

