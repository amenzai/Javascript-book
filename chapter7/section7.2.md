# 队列

队列是遵循FIFO（First In First Out，先进先出，也称为先来先服务）原则的一组有序的项。队列在尾部添加新元素，并从顶部移除元素。最新添加的元素必须排在队列的末尾。

## 代码示例：

```js
function Queue() {
  var items = [];
  this.enqueue = function(element) {
    items.push(element);
  };
  this.dequeue = function() {
    return items.shift();
  };
  this.front = function() {
    return items[0];
  };
  this.isEmpty = function() {
    return items.length == 0;
  };
  this.clear = function() {
    items = [];
  };
  this.size = function() {
    return items.length;
  };
  this.print = function() {
    console.log(items.toString());
  };
}
var queue = new Queue();

// ES6 实现Queue
let Queue2 = (function() {

  const items = new WeakMap();

  class Queue2 {
    constructor() {
      items.set(this, []);
    }
    enqueue(element) {
      let q = items.get(this);
      q.push(element);
    }
    dequeue() {
      let q = items.get(this);
      let r = q.shift();
      return r;
    }
    //其他方法
}
  return Queue2;
})();


// 优先队列
// 登飞机顺序
function PriorityQueue() {
  var items = [];

  function QueueElement(elelment, priority) {
    this.element = element;
    this.priority = priority;
  }
  this.enqueue = function(element, priority) {
    var queueElement = new QueueElement(element, priority);
    if (this.isEmpty()) {
      items.push(queueElement);
    } else {
      var added = false;
      for (var i = 0; i < items.length; i++) {
        if (queueElement.priority <
          items[i].priority) {
          items.splice(i, 0, queueElement);
          added = true;
          break;
        }
      }
      if (!added) {
        items.push(queueElement);
      }
    }
  };
  this.print = function(){
    for (let i=0; i<items.length; i++){
      console.log(`${items[i].element} -
      ${items[i].priority}`);
    }
  };
  //其他方法和默认的Queue实现相同
}

// 循环队列—
// 击鼓传花游戏
function hotPotato(nameList, num) {
  var queue = new Queue(); // {1}
  for (var i = 0; i < nameList.length; i++) {
    queue.enqueue(nameList[i]); // {2}
  }
  var eliminated = '';
  while (queue.size() > 1) {
    for (var i = 0; i < num; i++) {
      queue.enqueue(queue.dequeue()); // {3}
    }
    eliminated = queue.dequeue(); // {4}
    console.log(eliminated + '在击鼓传花游戏中被淘汰。');
  }
  return queue.dequeue(); // {5}
}
var names = ['John', 'Jack', 'Camila', 'Ingrid', 'Carl'];
var winner = hotPotato(names, 7);
console.log('胜利者：' + winner);
```