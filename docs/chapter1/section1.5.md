# 对象
创建方法：
```js
var o1 = {};
var o2 = new Object();
var o3 = Object.create(Object.prototype); //用于继承
```

## 表达式还是语句？
JavaScript规定，如果行首是大括号，一律解释为语句（即代码块）。如果要解释为表达式（即对象），必须在大括号前加上圆括号。
```js
eval('{foo: 123}') // 123
eval('({foo: 123})') // {foo: 123}
```

## 检查变量是否声明
```js
if ('a' in window) {
  // 变量 a 声明过
} else {
  // 变量 a 未声明
}
```
## 查看所有属性
```js
var o = {
  key1: 1,
  key2: 2
};

Object.keys(o);
// ['key1', 'key2']
```
## 删除属性delete 
delete命令只能删除对象本身的属性，无法删除继承的属性
```js
var o = Object.defineProperty({}, 'p', {
  value: 123,
  configurable: false
});

o.p // 123
delete o.p // false
```
## in运算符
in运算符检查对象是否包含对应属性
```js
// 假设变量x未定义

// 写法一：报错
if (x) { return 1; }

// 写法二：不正确
if (window.x) { return 1; }

// 写法三：正确
if ('x' in window) { return 1; }
```

in运算符的一个问题是，它不能识别对象继承的属性。可以用`hasOwnproperty()`

```js
var o = new Object();
o.hasOwnProperty('toString') // false

'toString' in o // true
```
## for…in循环

`for...in`循环用来遍历一个对象的全部属性。
它遍历的是对象所有可遍历（enumerable）的属性，会跳过不可遍历的属性
它不仅遍历对象自身的属性，还遍历继承的属性（使用构造函数和原型创建的对象）。
```js
// name 是 Person 本身的属性
function Person(name) {
  this.name = name;
}

// describe是Person.prototype的属性
Person.prototype.describe = function () {
  return 'Name: '+this.name;
};

var person = new Person('Jane');

// for...in循环会遍历实例自身的属性（name），
// 以及继承的属性（describe）
for (var key in person) {
  console.log(key);
}
// name
// describe
```
## with语句
它的作用是操作同一个对象的多个属性时，提供一些书写的方便。
```js
// 例一
with (o) {
  p1 = 1;
  p2 = 2;
}
// 等同于
o.p1 = 1;
o.p2 = 2;
```
单纯从上面的代码块，根本无法判断x到底是全局变量，还是o对象的一个属性。
这非常不利于代码的除错和模块化，编译器也无法对这段代码进行优化，只能留到运行时判断，这就拖慢了运行速度。
因此，建议不要使用with语句，可以考虑用一个临时变量代替with。
```js
with(o1.o2.o3) {
  console.log(p1 + p2);
}

// 可以写成

var temp = o1.o2.o3;
console.log(temp.p1 + temp.p2);
```

